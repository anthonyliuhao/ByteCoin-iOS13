//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
      
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    // This specifies the number of columns in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // This specifics the number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        /*
         This method expects a String as an output. The String is the title for a given row. When the
         PickerView is loading up, it will ask its delegate for a row title and call the above method once
         for every row. So when it is trying to get the title for the first row, it will pass in a row value
         of 0 and a component (column) value of 0.
         */
        return coinManager.currencyArray[row]
    }
    
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        /*
         This will get called every time when the user scrolls the picker. When that happens it will record
         the row number that was selected.
         */
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(currency: selectedCurrency)
    }
    
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didGetCoinRate(currency: String, rate: Double) {
        
        DispatchQueue.main.async {
            self.currencyLabel.text = currency
            self.bitcoinLabel.text = String(format: "%.2f", rate)
        }
    }
}

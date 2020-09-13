//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    var apiKey: String?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    init() {
        
        // Read the API key from the coinApiKey.txt file
        if let keyPath = Bundle.main.path(forResource: "coinApiKey", ofType:"txt") {
            
            do {
                let fileContents = try String(contentsOfFile: keyPath, encoding: .utf8)
                self.apiKey = fileContents.trimmingCharacters(in: .whitespacesAndNewlines)
            } catch {
                print(error)
            }
        }
        print(self.apiKey!)
    }
    
    func getCoinPrice(currency: String) -> String {
        
        let urlString = "\(baseURL)/\(currency)?apikey=\(self.apiKey!)"
        performRequest(with: urlString)
        return currency
    }
    
    func performRequest(with urlString: String) {
        // Create the URL
        if let url = URL(string: urlString) {
            
            // Initialize a session
            let session = URLSession(configuration: .default)
            
            // Give it a task and specify the call back
            let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(btcData: safeData)
                }
                
            })
            // Start the task
            task.resume()
        }
    }
    
    func parseJSON(btcData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(BitcoinData.self, from: btcData)
            print("\(decodedData.rate)")
        } catch {
            print(error)
        }
    }
}

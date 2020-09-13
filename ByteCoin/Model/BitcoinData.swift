//
//  BitcoinData.swift
//  ByteCoin
//
//  Created by Anthony Liu on 2020/9/12.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct BitcoinData: Decodable {
    var rate: Double
    var asset_id_quote: String
}

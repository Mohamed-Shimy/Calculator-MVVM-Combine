//
//  Currency.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

enum Currency: String {
    
    case egp
    case usd
    
    var symbol: String {
        rawValue.uppercased()
    }
}

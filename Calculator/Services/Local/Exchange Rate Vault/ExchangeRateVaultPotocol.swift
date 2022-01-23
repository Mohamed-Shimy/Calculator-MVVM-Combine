//
//  ExchangeRateVaultPotocol.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

protocol ExchangeRateVaultProtocol: AnyObject {
    
    var rate: Double { get set }
    var fromCurrency: Currency? { get set }
    var toCurrency: Currency? { get set }
}

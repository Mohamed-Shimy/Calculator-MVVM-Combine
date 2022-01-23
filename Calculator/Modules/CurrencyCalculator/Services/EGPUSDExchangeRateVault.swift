//
//  EGPUSDExchangeRateVault.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

class EGPUSDExchangeRateVault: ExchangeRateVaultProtocol {
    
    var rate: Double = 1/15.7
    var fromCurrency: Currency? = .egp
    var toCurrency: Currency? = .usd
}

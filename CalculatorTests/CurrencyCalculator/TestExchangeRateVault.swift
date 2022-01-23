//
//  TestExchangeRateVault.swift
//  CalculatorTests
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation
@testable import Calculator

class TestExchangeRateVault: ExchangeRateVaultProtocol {
    
    var rate: Double = 1/15.7
    var fromCurrency: Currency? = .egp
    var toCurrency: Currency? = .usd
}

//
//  ExchangeRateVault.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

class ExchangeRateVault: ExchangeRateVaultProtocol {
    
    static let open = ExchangeRateVault()
    
    @AppStorage("rate") var rate: Double = 0
    @AppStorage("fromCurrency") var fromCurrencyRawValue: String = ""
    @AppStorage("toCurrancy") var toCurrancyRawValue: String = ""
    
    var fromCurrency: Currency? {
        get { Currency(rawValue: fromCurrencyRawValue.lowercased()) }
        set { fromCurrencyRawValue = newValue?.rawValue ?? "" }
    }
    
    var toCurrency: Currency? {
        get { Currency(rawValue: toCurrancyRawValue.lowercased()) }
        set { toCurrancyRawValue = newValue?.rawValue ?? "" }
    }
    
    private init() { }
}

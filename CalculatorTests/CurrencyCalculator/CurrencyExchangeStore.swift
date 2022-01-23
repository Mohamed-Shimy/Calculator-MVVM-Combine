//
//  CurrencyExchangeStore.swift
//  CalculatorTests
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation
@testable import Calculator

final class USDCurrencyExchangeStore {
    
    static let open = USDCurrencyExchangeStore()
    
    private var rates: [String: Double] = [
        "usd": 1,
        "egp": 1/15.7
    ]
    
    private init() { }
    
    func convert(_ amount: Double, from: String, to: String) -> CurrencyExchangeModel? {
        guard amount >= 0 else { return nil }
        guard let fromRate = rates[from.lowercased()],
              let toRate = rates[to.lowercased()]
        else { return .init(fromType: from, fromValue: "\(amount)", toType: to, valid: false) }
        let result = amount * (fromRate / toRate)
        let model = CurrencyExchangeModel(fromType: from,
                                          fromValue: "\(amount)",
                                          toType: to,
                                          resultString: "\(result)",
                                          result: result,
                                          valid: true)
        return model
    }
}

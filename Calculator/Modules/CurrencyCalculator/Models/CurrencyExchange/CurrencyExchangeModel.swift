//
//  CurrencyExchangeModel.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

struct CurrencyExchangeModel: Codable {
    
    var fromType, fromValue, toType, resultString: String?
    var result: Double?
    var valid: Bool?
    
    enum CodingKeys: String, CodingKey {
        case valid
        case resultString = "result"
        case fromType = "from-type"
        case fromValue = "from-value"
        case result = "result-float"
        case toType = "to-type"
    }
}

extension CurrencyExchangeModel {
    
    var uiModel: CurrencyExchange? {
        guard let result = result else { return nil }
        return CurrencyExchange(result: result,
                                valid: valid ?? false)
    }
}

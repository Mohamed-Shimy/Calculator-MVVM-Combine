//
//  TextCurrencyNetworkManager.swift
//  CalculatorTests
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation
import Combine
@testable import Calculator

class TestCurrencyNetworkManager: CurrencyNetworkProtocol {
    
    func convert(_ amount: Double, from: String, to: String) -> AnyPublisher<CurrencyExchangeModel, NetworkError> {
        return CurrencyExchangeResponse()
            .convert(amount, from: from, to: to)
    }
}

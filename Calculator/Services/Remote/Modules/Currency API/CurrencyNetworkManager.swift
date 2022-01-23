//
//  CurrencyNetworkManager.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation
import Combine

class CurrencyNetworkManager: CurrencyNetworkProtocol  {
    
    private let manager = NetworkManager<CurrencyAPI>()
    
    func convert(_ amount: Double, from: String, to: String) -> AnyPublisher<CurrencyExchangeModel, NetworkError> {
        manager.request(target: .convert(amount, from: from, to: to))
    }
}

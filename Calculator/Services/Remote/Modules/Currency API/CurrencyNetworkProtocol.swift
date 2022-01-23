//
//  CurrencyNetworkProtocol.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Combine

protocol CurrencyNetworkProtocol: AnyObject {
    
    func convert(_ amount: Double, from: String, to: String) -> AnyPublisher<CurrencyExchangeModel, NetworkError>
}

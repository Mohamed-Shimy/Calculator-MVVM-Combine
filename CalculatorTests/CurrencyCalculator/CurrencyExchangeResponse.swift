//
//  CurrencyExchangeResponse.swift
//  CalculatorTests
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation
import Combine
@testable import Calculator

struct CurrencyExchangeResponse: Publisher {
    
    typealias Output = CurrencyExchangeModel
    typealias Failure = NetworkError
    
    private let sender = CurrentValueSubject<Output, Failure>(.init())
    private let exchangeStore = USDCurrencyExchangeStore.open
    
    func receive<S>(subscriber: S) where S : Subscriber, NetworkError == S.Failure, CurrencyExchangeModel == S.Input {
        sender.receive(subscriber: subscriber)
    }
    
    func convert(_ amount: Double, from: String, to: String) -> AnyPublisher<Output, Failure> {
        if let model = exchangeStore.convert(amount, from: from, to: to) {
            sender.send(model)
        } else {
            let error = NetworkError(0, message: "Cannot Convert")
            sender.send(completion: .failure(error))
        }
        return sender.eraseToAnyPublisher()
    }
}

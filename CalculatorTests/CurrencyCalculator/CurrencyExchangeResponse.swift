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
    
    private let passThroughSubject = PassthroughSubject<Output, Failure>()
    
    func receive<S>(subscriber: S) where S : Subscriber, NetworkError == S.Failure, CurrencyExchangeModel == S.Input {
        passThroughSubject.receive(subscriber: subscriber)
    }
    
    func convert(_ amount: Double, from: String, to: String) -> AnyPublisher<Output, Failure> {
        if Currency(rawValue: from.lowercased()) == .egp, Currency(rawValue: to.lowercased()) == .usd {
            let result = amount * 15.7
            let model = CurrencyExchangeModel(fromType: from, fromValue: "\(amount)",
                                              toType: to, resultString: "\(result)",
                                              result: result, valid: true)
            passThroughSubject.send(model)
        } else {
            let error = NetworkError(0, message: "Cannot Convert")
            passThroughSubject.send(completion: .failure(error))
        }
        
        return passThroughSubject.eraseToAnyPublisher()
    }
}

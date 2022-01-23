//
//  CurrencyCalculatorViewModelProtocol.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

protocol CurrencyCalculatorViewModelProtocol: ObservableObject {
    
    var currencyInput: String { get set }
    var result: Double { get }
    var isLoading: Bool { get set }
    var isLocalResult: Bool { get set }
    var error: NetworkError? { get set }
    
    init(networkManager: CurrencyNetworkProtocol, exchangeVault: ExchangeRateVaultProtocol)
    func convert(currency from: Currency, to: Currency)
    func setRemote(result: Double)
}

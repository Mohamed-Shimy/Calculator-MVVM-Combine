//
//  CurrencyCalculatorViewModel.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation
import Combine

typealias CancellableBag = Set<AnyCancellable>

final class CurrencyCalculatorViewModel: CurrencyCalculatorViewModelProtocol {
    
    // MARK: - Properties
    
    @Published var currencyInput = ""
    @Published var isLoading = false
    @Published var isLocalResult = false
    @Published var error: NetworkError? = nil
    @Published private(set) var result: Double = 0 {
        didSet {
            lastPostedResult = .init(result: result)
        }
    }
    
    private let exchangeVault: ExchangeRateVaultProtocol
    private let networkManager: CurrencyNetworkProtocol
    private var lastPostedResult: LastExchangeConversionItem?
    private var cancellableBag = CancellableBag()
    
    var canPostResult: Bool {
        if lastPostedResult != nil {
            lastPostedResult = nil
            return true
        }
        return false
    }
    
    // MARK: - init
    
    required init(networkManager: CurrencyNetworkProtocol = CurrencyNetworkManager(),
                  exchangeVault: ExchangeRateVaultProtocol = ExchangeRateVault.open) {
        self.networkManager = networkManager
        self.exchangeVault = exchangeVault
    }
    
    // MARK: - Methods
    
    func convert(currency from: Currency, to: Currency) {
        isLoading = true
        let amount = Double(currencyInput) ?? 1
        networkManager.convert(amount, from: from.symbol, to: to.symbol)
            .tryCompactMap(\.uiModel)
            .sink { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                self.isLocalResult = false
                if self.isFailureResponse(result) {
                    self.tryConvertFromSavedRate(amount, from: from, to: to)
                }
            } receiveValue: { [weak self] exchange in
                if exchange.valid {
                    self?.result = exchange.result
                    self?.saveLastRate(amount, result: exchange.result, from: from, to: to)
                } else {
                    self?.tryConvertFromSavedRate(amount, from: from, to: to)
                }
            }.store(in: &cancellableBag)
    }
    
    func setRemote(result: Double) {
        currencyInput = "\(result)"
    }
    
    // MARK: - Private Methods
    
    private func isFailureResponse(_ result: Subscribers.Completion<Error>) -> Bool {
        guard case .failure(let error) = result else { return false }
        if let error = error as? NetworkError {
            self.error = error
        } else {
            self.error = .unkown
        }
        return true
    }
    
    private func tryConvertFromSavedRate(_ amount: Double, from: Currency, to: Currency) {
        guard from == exchangeVault.fromCurrency,
              to == exchangeVault.toCurrency
        else { return }
        isLocalResult = true
        result = amount * exchangeVault.rate
    }
    
    private func saveLastRate(_ amount: Double, result: Double, from: Currency, to: Currency) {
        exchangeVault.rate = result / amount
        exchangeVault.fromCurrency = from
        exchangeVault.toCurrency = to
    }
}

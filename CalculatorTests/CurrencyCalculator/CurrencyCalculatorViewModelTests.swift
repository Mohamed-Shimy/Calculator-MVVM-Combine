//
//  CurrencyCalculatorViewModelTests.swift
//  CalculatorTests
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import XCTest
import Combine
@testable import Calculator

class CurrencyCalculatorViewModelTests: XCTestCase {
    
    var viewModel: CurrencyCalculatorViewModel!
    var networkManager: TestCurrencyNetworkManager!
    var exchangeRateVault: TestExchangeRateVault!
    var cancellableBag: CancellableBag!
    
    override func setUpWithError() throws {
        networkManager = .init()
        exchangeRateVault = .init()
        viewModel = .init(networkManager: networkManager, exchangeVault: exchangeRateVault)
        cancellableBag = .init()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        networkManager = nil
        exchangeRateVault = nil
        cancellableBag = nil
    }
    
    func testValidExchange() throws {
        convert("15.7", from: .egp, to: .usd)
        let resultExp = self.expectation(description: "viewModel.result")
        viewModel.$result.sink { result in
            XCTAssert(self.viewModel.result == 1, "result: \(self.viewModel.result)")
            
            resultExp.fulfill()
        }.store(in: &cancellableBag)
        waitForExpectations(timeout: 10)
    }
    
    func testErrorExchange() {
        convert("-1", from: .egp, to: .usd)
        let errorExp = self.expectation(description: "viewModel.error")
        viewModel.$error.sink { error in
            XCTAssertNotNil(error, error?.message ?? "unkown error")
            
            errorExp.fulfill()
        }.store(in: &cancellableBag)
        waitForExpectations(timeout: 10)
    }
    
    func testSetRemoteResult() {
        viewModel.setRemote(result: 15.7)
        viewModel.convert(currency: .egp, to: .usd)
        let resultExp = self.expectation(description: "viewModel.result")
        viewModel.$result.sink { result in
            XCTAssert(self.viewModel.result == 1, "result: \(self.viewModel.result)")
            
            resultExp.fulfill()
        }.store(in: &cancellableBag)
        waitForExpectations(timeout: 10)
    }
    
    private func convert(_ amount: String, from: Currency, to: Currency) {
        viewModel.currencyInput = amount
        viewModel.convert(currency: from, to: to)
    }
}

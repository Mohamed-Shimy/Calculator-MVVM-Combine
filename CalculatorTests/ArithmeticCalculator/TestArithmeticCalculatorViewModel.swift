//
//  TestArithmeticCalculatorViewModel.swift
//  CalculatorTests
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import XCTest
@testable import Calculator

class ArithmeticCalculatorTests: XCTestCase {
    
    private var viewModel: ArithmeticCalculatorViewModel!
    
    override func setUpWithError() throws {
        viewModel = ArithmeticCalculatorViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testDoOperation() throws {
        doOperation("2", op: .plus)
        
        XCTAssert(viewModel.result == 2, "not right: \(viewModel.result)")
        XCTAssert(viewModel.history.count == 1, "not one: \(viewModel.history.count)")
    }
    
    private func doOperation(_ input: String, op: Operator) {
        viewModel.setOperator(op)
        viewModel.inputText = input
        viewModel.setOperator(.equal)
    }
}

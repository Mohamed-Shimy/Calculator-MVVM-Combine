//
//  ArithmeticCalculatorView.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

struct ArithmeticCalculatorView<ViewModel: ArithmeticCalculatorViewModelProtocol>: View {
    
    // MARK: - Public Properties
    
    @StateObject var viewModel: ViewModel
    private(set) var notificationCenter: Notifiable = NotificationCenter.default
    
    // MARK: - View Body
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(viewModel.result, specifier: "Result = %.1f")")
            TextField("Please enter the second operand", text: $viewModel.inputText)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            
            ArithmeticCalculatorOperationsView(Operator.allCases,
                                     undoEnabled: $viewModel.canUndo,
                                     redoEnabled: $viewModel.canRedo)
                .onUndo(viewModel.undo)
                .onRedo(viewModel.redo)
                .onOperator(viewModel.setOperator)
            
            ArithmeticCalculatorHistoryView(items: viewModel.history, onTapCell: viewModel.undoItem)
        }
        .padding()
        .onDisappear {
            postLastResult()
        }.onReceive(NotificationCenter.default.publisher(for: .currencyCalculatorResult)) { notification in
            if let result = notification.object as? Double {
                viewModel.setRemote(result: result)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func postLastResult() {
        notificationCenter.post(name: .arithmeticCalculatorResult, object: viewModel.result)
    }
}

struct ArithmeticCalculatorView_Previews: PreviewProvider {
    
    static var previews: some View {
        ArithmeticCalculatorView(viewModel: ArithmeticCalculatorViewModel(), notificationCenter: NotificationCenter.default)
    }
}

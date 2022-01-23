//
//  CurrencyCalculatorView.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

struct CurrencyCalculatorView<ViewModel: CurrencyCalculatorViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    let notificationCenter: Notifiable = NotificationCenter.default
    
    private let fromCurrency: Currency = .egp
    private let toCurrency: Currency = .usd
    
    var body: some View {
        VStack(spacing: 25) {
            TextField(fromCurrency.symbol, text: $viewModel.currencyInput)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            
            VStack {
                Text("\(viewModel.result, specifier: "%.1f \(toCurrency.symbol)")")
                if viewModel.isLocalResult {
                    Text("Local result from last rate")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
            }
            
            LoadingButton("Convert", isLoading: $viewModel.isLoading) {
                viewModel.convert(currency: fromCurrency, to: toCurrency)
            }
        }
        .padding()
        .alert(item: $viewModel.error) { error in
            Alert("Error", message: error.message, dismissButton: .cancel())
        }
        .onDisappear {
            postLastResult()
        }
        .onReceive(notificationCenter.publisher(for: .arithmeticCalculatorResult)) { notification in
            if let result = notification.object as? Double {
                viewModel.setRemote(result: result)
            }
        }
    }
    
    private func postLastResult() {
        guard viewModel.canPostResult else { return }
        notificationCenter.post(name: .currencyCalculatorResult, object: viewModel.result)
    }
}

struct CurrencyCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCalculatorView(viewModel: CurrencyCalculatorViewModel())
    }
}

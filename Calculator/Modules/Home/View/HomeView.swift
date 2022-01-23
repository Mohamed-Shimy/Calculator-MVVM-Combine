//
//  HomeView.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

struct HomeView: View {
        
    var body: some View {
        TabView {
            ArithmeticCalculatorView(viewModel: ArithmeticCalculatorViewModel())
                .tabItem(Tab.arithmeticCalculator.label)
            
            /*
             After implementing the api to convert from  neutrinoapi.net
             I've reached the daily limit.
             `EGPUSDExchangeRateVault`: for test, if the service failed
             */
            CurrencyCalculatorView(viewModel: CurrencyCalculatorViewModel(exchangeVault: EGPUSDExchangeRateVault()))
                .tabItem(Tab.currencyCalculator.label)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}

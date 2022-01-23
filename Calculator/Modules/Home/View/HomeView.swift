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
            Text(Tab.arithmeticCalculator.title)
                .tabItem(Tab.arithmeticCalculator.label)
            
            Text(Tab.currencyCalculator.title)
                .tabItem(Tab.currencyCalculator.label)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}

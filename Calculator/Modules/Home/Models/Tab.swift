//
//  Tab.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

enum Tab: CaseIterable {
    
    case arithmeticCalculator
    case currencyCalculator
    
    var title: String {
        switch self {
            case .arithmeticCalculator: return "Calculator"
            case .currencyCalculator: return "Currency"
        }
    }
    
    var systemImage: String {
        switch self {
            case .arithmeticCalculator: return "plus.forwardslash.minus"
            case .currencyCalculator: return "coloncurrencysign.circle"
        }
    }    
}

extension Tab {
    
    func label() -> Label<Text, Image> {
        Label(title, systemImage: systemImage)
    }
}

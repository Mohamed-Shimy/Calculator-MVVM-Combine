//
//  Operator.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

enum Operator: String, CaseIterable {
    
    case plus = "+"
    case minus = "-"
    case mul = "*"
    case div = "/"
    case equal = "="
    
    var symbol: String { rawValue }
    
    var invert: Operator {
        switch self {
            case .plus: return .minus
            case .minus: return .plus
            case .mul: return .div
            case .div: return .mul
            case .equal: return .equal
        }
    }
}

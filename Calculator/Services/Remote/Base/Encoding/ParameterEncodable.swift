//
//  ParameterEncodable.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

protocol ParameterEncodable {
    
    var queryItems: [URLQueryItem]? { get }
    var bodyData: Data? { get }
    
    init(_ parameters: [String: Any])
}

extension ParameterEncodable {
    
    var queryItems: [URLQueryItem]? { nil }
    var bodyData: Data? { nil }
}

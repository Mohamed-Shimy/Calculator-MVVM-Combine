//
//  HttpBodyEncoding.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

struct HttpBodyEncoding: ParameterEncodable {
    
    let bodyData: Data?
    
    init(_ parameters: [String: Any]) {
        bodyData = parameters.map { "\($0.key)=\($0.value)" }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

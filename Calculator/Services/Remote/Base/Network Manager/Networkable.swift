//
//  Networkable.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Combine

protocol Networkable: AnyObject {
    
    associatedtype Target: TargetType
    func request<C: Codable>(target: Target) -> AnyPublisher<C, NetworkError>
}

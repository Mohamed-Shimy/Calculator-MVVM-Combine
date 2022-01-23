//
//  NetworkManager.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation
import Combine

class NetworkManager<Target: TargetType>: Networkable {
    
    func request<C: Codable>(target: Target) -> AnyPublisher<C, NetworkError> {
        let session = URLSession.shared
        let request = target.buildURLRequest()
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unkown
                }
                if let error = NetworkError(code: httpResponse.statusCode) {
                    throw error
                }
                return data
            }
            .decode(type: C.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError(0, message: error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

//
//  Notifiable.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation
import Combine

protocol Notifiable: AnyObject {
    
    func post(name: NSNotification.Name, object: Any?)
    func publisher(for name: Notification.Name) -> AnyPublisher<Notification, Never>
}

//
//  NotificationCenter + Notifiable.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation
import Combine

extension NotificationCenter: Notifiable {
    
    func publisher(for name: Notification.Name) -> AnyPublisher<Notification, Never> {
        publisher(for: name, object: nil).eraseToAnyPublisher()
    }
}

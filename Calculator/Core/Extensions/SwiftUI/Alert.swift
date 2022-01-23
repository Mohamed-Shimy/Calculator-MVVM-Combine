//
//  Alert.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

extension Alert {
    
    init(_ title: String, message: String? = nil, dismissButton: Alert.Button? = nil) {
        let messageText = message == nil ? nil : Text(message!)
        self.init(title: Text(title), message: messageText, dismissButton: dismissButton)
    }
}

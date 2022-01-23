//
//  LoadingButton.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

struct LoadingButton: View {
    
    var title: String
    @Binding var isLoading: Bool
    var action: () -> ()
    
    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView("Converting")
                        .frame(minWidth: 40, minHeight: 40)
                        .progressViewStyle(.circular)
                } else {
                    Text(title)
                }
            }
        }.disabled(isLoading)
    }
    
    init(_ title: String, isLoading: Binding<Bool>, action: @escaping () -> ()) {
        self.title = title
        _isLoading = isLoading
        self.action = action
    }
}


struct LoadingButton_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            LoadingButton("Convert", isLoading: .constant(false), action: {})
            LoadingButton("Convert", isLoading: .constant(true), action: {})
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

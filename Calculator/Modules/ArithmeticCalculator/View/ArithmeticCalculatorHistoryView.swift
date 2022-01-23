//
//  ArithmeticCalculatorHistoryView.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

struct ArithmeticCalculatorHistoryView: View {
    
    // MARK: - Public Properties
    
    var items: History<Operation>
    var onTapCell: ((Operation) -> ())?
    
    // MARK: - View Body
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem()], spacing: 15) {
                ForEach(items) { item in
                    ArithmeticCalculatorHistoryCellView(item: item)
                        .onTapGesture { onTapCell?(item) }
                }
            }
            .padding()
        }
        .background(Color.black)
        .cornerRadius(5)
        .shadow(color: Color.primary.opacity(0.3), radius: 5)
    }
}

struct ArithmeticCalculatorHistoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        ArithmeticCalculatorHistoryView(items: [])
    }
}

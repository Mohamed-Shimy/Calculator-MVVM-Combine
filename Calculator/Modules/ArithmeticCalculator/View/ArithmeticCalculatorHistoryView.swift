//
//  ArithmeticCalculatorHistoryView.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

struct ArithmeticCalculatorHistoryView: View {
    
    // MARK: - Public Properties
    
    private(set) var items: History<Operation>
    private(set) var onTapCell: ((Operation) -> ())?
    private(set) var columns: [GridItem] = Array(repeating: GridItem(.flexible(minimum: 50)), count: 3)
    
    // MARK: - View Body
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
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

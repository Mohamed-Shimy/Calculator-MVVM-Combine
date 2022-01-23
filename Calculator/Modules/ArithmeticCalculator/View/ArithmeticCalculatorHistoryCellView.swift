//
//  ArithmeticCalculatorHistoryCellView.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

struct ArithmeticCalculatorHistoryCellView: View {
    
    let item: Operation
    
    var body: some View {
        Text("\(item.secondOperand, specifier: "\(item.oprator.symbol) %.1f")")
            .padding(10)
            .foregroundColor(.white)
            .lineLimit(1)
            .border(Color.white, width: 2)
            .cornerRadius(3)
    }
}

struct ArithmeticCalculatorHistoryCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        ArithmeticCalculatorHistoryCellView(item: Operation(oprator: .plus, result: 0))
            .previewLayout(.sizeThatFits)
    }
}

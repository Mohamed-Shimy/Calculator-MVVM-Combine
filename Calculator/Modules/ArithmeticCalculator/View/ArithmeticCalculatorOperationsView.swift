//
//  ArithmeticCalculatorOperationsView.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import SwiftUI

struct ArithmeticCalculatorOperationsView: View {
    
    // MARK: - Public Properties
    
    var operators: [Operator]
    @Binding var undoEnabled: Bool
    @Binding var redoEnabled: Bool
    
    // MARK: - Private Properties
    
    private var onOperator: ((Operator) -> ())? = nil
    private var onUndo: (() -> ())? = nil
    private var onRedo: (() -> ())? = nil
    
    // MARK: - View Body
    
    var body: some View {
        HStack {
            Button("Undo", action: { onUndo?() })
                .disabled(!undoEnabled)
            Spacer()
            ForEach(operators, id: \.self) { op in
                Button(op.symbol, action: { onOperator?(op) })
                    .frame(minWidth: 32)
                Spacer()
            }
            Button("Redo", action: { onRedo?() })
                .disabled(!redoEnabled)
        }
        .frame(maxWidth: .infinity, minHeight: 32)
    }
    
    // MARK: - init
    
    init(_ operators: [Operator], undoEnabled: Binding<Bool>, redoEnabled: Binding<Bool>) {
        self.operators = operators
        self._undoEnabled = undoEnabled
        self._redoEnabled = redoEnabled
    }
    
    // MARK: - Public Methods
    
    func onOperator(_ perform: @escaping ((Operator) -> ())) -> Self {
        var view = self
        view.onOperator = perform
        return view
    }
    
    func onUndo(_ perform: @escaping (() -> ())) -> Self {
        var view = self
        view.onUndo = perform
        return view
    }
    
    func onRedo(_ perform: @escaping (() -> ())) -> Self {
        var view = self
        view.onRedo = perform
        return view
    }
}

struct ArithmeticCalculatorOperationsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ArithmeticCalculatorOperationsView(Operator.allCases, undoEnabled: .constant(false), redoEnabled: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}

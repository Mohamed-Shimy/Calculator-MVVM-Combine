//
//  History.swift
//  Calculator
//
//  Created by Mohamed Shemy on Sun 23 Jan, 2022.
//

import Foundation

struct History<T> {
    
    private var array: [T] = []
    private var undoCount = 0
    private var pointer = -1
    
    var canRedo: Bool { undoCount > 0 }
    var canUndo: Bool { pointer < array.count }
    
    mutating func append(_ item: T) {
        array.insert(item, at: 0)
        pointer = 0
        undoCount = 0
    }
    
    mutating func undo(_ transform: (T) -> T) {
        guard let item = array[safe: pointer] else { return }
        array.insert(transform(item), at: 0)
        pointer += 2 // one for undo , one for the new item
        undoCount += 1
    }
    
    mutating func undo(item: T, newItem: () -> T) where T: Equatable {
        guard let index = array.firstIndex(where: { item == $0 }) else { return }
        pointer = 0
        undoCount = index + 1
        array.insert(newItem(), at: 0)
    }
    
    mutating func redo(_ transform: (T) -> T) {
        guard let item = array[safe: pointer - 1] else { return }
        array.insert(transform(item), at: 0)
        undoCount -= 1
    }
}

extension History: ExpressibleByArrayLiteral {
    
    init(arrayLiteral elements: T...) {
        elements.forEach { item in
            append(item)
        }
    }
}

extension History: Collection, RandomAccessCollection {
    
    var startIndex: Int { array.startIndex }
    var endIndex: Int { array.endIndex }
    
    func index(after i: Int) -> Int { array.index(after: i) }
    
    subscript(position: Int) -> T {
        array[position]
    }
}

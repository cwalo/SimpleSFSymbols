//
//  Symbol.swift
//  SimpleSFSymbols
//
//  Created by Corey Walo on 4/22/25.
//

import Foundation

public struct Symbol: Sendable {
    private(set) var symbolPath: [String] = []
    
    public var result: String {
        symbolPath.joined(separator: ".")
    }
        
    public func append(_ value: String) -> Self {
        var copy = self
        copy.symbolPath.append(value)
        return copy
    }
}

public extension Symbol {
    static let symbol = Symbol()
}

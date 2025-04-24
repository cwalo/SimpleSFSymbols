import Foundation

public struct Symbol: Sendable {
    public private(set) var symbolPath: [String] = []
    
    public var systemName: String {
        return symbolPath.joined(separator: ".")
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

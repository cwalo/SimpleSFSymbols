//
//  Image+Symbol.swift
//  SimpleSFSymbols
//
//  Created by Corey Walo on 4/22/25.
//

import SwiftUI

extension Image {
    @available(iOS 13.0, macOS 11.0, tvOS 13.0, visionOS 1.0, watchOS 6.0, *)
    public init(_ symbol: Symbol) {
        self.init(systemName: symbol.systemName)
    }
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, visionOS 1, watchOS 9.0, *)
    public init(_ symbol: Symbol, variableValue: Double?) {
        self.init(systemName: symbol.systemName, variableValue: variableValue)
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, visionOS 1.0, watchOS 7.0, *)
extension Label where Icon == Image, Title == Text {
    public init(_ titleKey: LocalizedStringKey, symbol: Symbol) {
        self.init(titleKey, systemImage: symbol.systemName)
    }
}

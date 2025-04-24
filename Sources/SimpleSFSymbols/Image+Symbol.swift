//
//  Image+Symbol.swift
//  SimpleSFSymbols
//
//  Created by Corey Walo on 4/22/25.
//

import SwiftUI

extension Image {
    @available(iOS 13, macOS 11.0, tvOS 13, visionOS 1, watchOS 6, *)
    public init(_ symbol: Symbol) {
        self.init(systemName: symbol.systemName)
    }
}

//
//  GenerateSymbols.swift
//  SimpleSFSymbols
//
//  Created by Corey Walo on 4/22/25.
//

import Foundation

typealias ReleaseDate = String
typealias Symbol = String
typealias Symbols = [Symbol:ReleaseDate]
typealias Release = [String:String]
typealias Releases = [ReleaseDate:Release]
typealias SymbolTuple = (symbol:Symbol, released:ReleaseDate)

// https://github.com/jollyjinx/SFSymbolEnum/blob/main/generateSFSymbolEnum.swift
func symbolsAndReleases(from plist: URL) -> ( [SymbolTuple],Releases) {
    let data = try! Data.init(contentsOf: plist, options: .mappedIfSafe)
    let propertyList = try! PropertyListSerialization.propertyList(from:data,options:[],format:nil) as! Dictionary<String,Any>

    let symbols = propertyList["symbols"] as! Symbols
    let releases = propertyList["year_to_release"] as! Releases

    let releaseDatesFromSymbols = Set<ReleaseDate>(symbols.values)
    let releaseDatesFromReleases = Set<ReleaseDate>(releases.keys)

    assert(releaseDatesFromReleases.isSubset(of:releaseDatesFromSymbols),"There are symbols with relasedates that have no release versions \(releaseDatesFromReleases) < \(releaseDatesFromSymbols)")

    let sortedSymbolTuple =
        symbols
            .sorted{ $0.value == $1.value ? $0.key < $1.key : $0.value < $1.value}
            .map{ SymbolTuple(symbol:$0.key,released:$0.value) }

    return (sortedSymbolTuple,releases)
}

@main
struct GenerateSymbols {
    static func main() throws {
        let outputDirectory = CommandLine.arguments[1]
        let outputAllSymbolsPath = URL(fileURLWithPath: outputDirectory).appendingPathComponent("SymbolLiterals.generated.swift")
        let outputComponentsPath = URL(fileURLWithPath: outputDirectory).appendingPathComponent("Symbols.generated.swift")
        let plistPath = URL(fileURLWithPath: "/Applications/SF Symbols.app/Contents/Resources/Metadata/name_availability.plist")
        
        let (symbols, _) = symbolsAndReleases(from: plistPath)
        
        var symbolSet = Set<String>()
        var numericSymbols = Set<String>()
        for tuple in symbols {
            let components = tuple.symbol.components(separatedBy: ".")
            for component in components {
                let part = String(component)
                let startsWithNumber = part.first?.isNumber ?? false
                if startsWithNumber {
                    numericSymbols.insert(part)
                } else {
                    symbolSet.insert(part)
                }
            }
        }
        
        // Create Symbol Literals
        func writeSymbolLiterals() throws {
            let header = "// Generated symbol literals file\n// Re-regenerate by right-clicking project in Xcode Navigator -> SymbolGeneratorPlugin -> Run\n"
            let imports = "import Foundation\nimport SimpleSFSymbols\n\n"
            let open = "extension Symbol {\n"
            let setDefinition = "    public static let validSymbols: Set<String> = [\n"
            let setDefinitionClose = "    ]\n"
            let close = "}"
            
            var output = header + imports + open + setDefinition
            
            for symbol in symbols.map(\.symbol) {
                output += "        \"\(symbol)\",\n"
            }
            
            output += setDefinitionClose + close
            try output.write(to: outputAllSymbolsPath, atomically: true, encoding: .utf8)
        }
        
        // Create Component Accessors
        func writeSymbolComponents() throws {
            let header = "// Generated symbols file\n// Re-regenerate by right-clicking project in Xcode Navigator -> SymbolGeneratorPlugin -> Run\n"
            let imports = "import Foundation\nimport SimpleSFSymbols\n\n"
            let open = "extension Symbol {\n"
            let close = "}"
            var output = header + imports + open
            
            for symbol in numericSymbols {
                let property = "num"+symbol
                let accessor = "  public var \(property): Symbol { append(\"\(symbol)\") }\n"
                output += accessor
            }
            
            for symbol in symbolSet {
                let accessor = "  public var `\(symbol)`: Symbol { append(\"\(symbol)\") }\n"
                output += accessor
            }
            
            output += close
            
            try output.write(to: outputComponentsPath, atomically: true, encoding: .utf8)
        }
        
        try writeSymbolLiterals()
        try writeSymbolComponents()
    }
}

//
//  SymbolGeneratorPlugin.swift
//  SimpleSFSymbols
//
//  Created by Corey Walo on 4/22/25.
//

import Foundation
import PackagePlugin

@main
struct SymbolGeneratorPlugin: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) throws {
        let generator = try context.tool(named: "GenerateSymbols")
        
        let generatorPath = generator.url
        let target = try context.package.targets(named: ["SimpleSFSymbols"]).first!
        let outputPath = target.directory
        let args = [
            "\(outputPath)"
        ]
        let process = try Process.run(generatorPath, arguments: args)
        process.waitUntilExit()

        // Check whether the subprocess invocation was successful.
        if process.terminationReason == .exit && process.terminationStatus == 0 {
            print("Generated symbols successfully")
        }
        else {
            let problem = "\(process.terminationReason):\(process.terminationStatus)"
            Diagnostics.error("Failed to generate symbols: \(problem)")
        }
    }
}

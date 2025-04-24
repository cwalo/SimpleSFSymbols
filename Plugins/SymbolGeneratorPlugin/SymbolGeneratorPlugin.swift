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
        } else {
            let problem = "\(process.terminationReason):\(process.terminationStatus)"
            Diagnostics.error("Failed to generate symbols: \(problem)")
        }
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SymbolGeneratorPlugin: XcodeCommandPlugin {
    /// This entry point is called when operating on an Xcode project.
    func performCommand(context: XcodePluginContext, arguments: [String]) throws {
        let generator = try context.tool(named: "GenerateSymbols")
        let generatorPath = generator.url
        let projectName = context.xcodeProject.displayName
        let outputPath = context.xcodeProject.directoryURL
            .appending(path: projectName, directoryHint: .isDirectory)
            .appending(path: "GeneratedSymbols", directoryHint: .isDirectory)
        
        if !FileManager.default.fileExists(atPath: outputPath.path()) {
            try FileManager.default.createDirectory(at: outputPath, withIntermediateDirectories: false)
        }
        
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
#endif

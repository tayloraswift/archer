import Archer
import ArgumentParser
import System_ArgumentParser
import SystemIO

extension ArcherCommand
{
    struct Init
    {
        @Option(
            name: [.customLong("wasm-path"), .customShort("w")],
            help: "Where the browser should load the WebAssembly (wasm) binary from")
        var wasmPath:String = "main.wasm"

        @Option(
            name: [.customLong("js-name"), .customShort("m")],
            help: "What to name the generated JavaScript file",
            completion: .file(extensions: ["js"]))
        var jsName:String = "main.js"

        @Option(
            name: [.customLong("js-runtime"), .customShort("J")],
            help: "Where to find the JavaScriptKit runtime",
            completion: .directory)
        var jsRuntime:FilePath.Directory = """
            .build/release/JavaScriptKit_JavaScriptKit.resources
            """

        @Option(
            name: [.customLong("bundle"), .customShort("o")],
            help: "Where to write the generated resources to",
            completion: .directory)
        var bundle:FilePath.Directory
    }
}
extension ArcherCommand.Init:ParsableCommand
{
    mutating
    func run() throws
    {
        try self.bundle.create()
        let bundle:Archer.Bundle = .init(directory: self.bundle)
        try bundle.initialize(wasm: self.wasmPath,
            javascript: self.jsName,
            resources: self.jsRuntime)
    }
}

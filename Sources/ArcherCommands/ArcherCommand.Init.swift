import Archer
import ArgumentParser
import System_ArgumentParser
import SystemIO

extension ArcherCommand
{
    struct Init
    {
        @Option(
            name: [.customLong("wasm-path", withSingleDash: true), .customShort("w")],
            help: "Where the browser should load the WebAssembly (wasm) binary from")
        var wasmPath:String = "main.wasm"

        @Option(
            name: [.customLong("js-name", withSingleDash: true), .customShort("m")],
            help: "What to name the generated JavaScript file",
            completion: .file(extensions: ["js"]))
        var jsName:String = "main.js"

        @Option(
            name: [.customLong("js-runtime", withSingleDash: true), .customShort("J")],
            help: "Where to find the JavaScriptKit runtime",
            completion: .directory)
        var jsRuntime:FilePath.Directory = """
            .build/release/JavaScriptKit_JavaScriptKit.resources
            """

        @Option(
            name: [.customLong("bundle", withSingleDash: true), .customShort("o")],
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
        //  Check that the JavaScript runtime actually exists
        guard self.jsRuntime.exists()
        else
        {
            print("""
                error: JavaScript runtime not found at \(self.jsRuntime)

                hint: add a dependency on https://github.com/swiftwasm/JavaScriptKit and build \
                the project to have SwiftPM automatically download the correct version of the \
                JavaScript runtime

                hint: \(Archer.hintBuild)
                """
                )
            throw ExitCode.failure
        }

        try self.bundle.create()

        do
        {
            let bundle:Archer.Bundle = .init(directory: self.bundle)
            try bundle.initialize(wasm: self.wasmPath,
                javascript: self.jsName,
                resources: self.jsRuntime)
        }
        catch let error
        {
            if  case SystemProcessError.spawn(2, let invocation) = error,
                case "esbuild"? = invocation.first
            {
                print("""
                    error: it looks like 'esbuild' is not installed
                    """
                    )
                throw ExitCode.failure
            }

            throw error
        }

        print("""

            hint: copy a '\(self.wasmPath)', an appropriate 'index.html', and any other \
            necessary resources to this directory, and run

                esbuild --servedir=\(self.bundle)

            to preview your application in a browser
            """
            )
    }
}

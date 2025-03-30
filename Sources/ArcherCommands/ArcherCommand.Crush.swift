import Archer
import ArgumentParser
import System_ArgumentParser
import SystemIO

extension ArcherCommand
{
    struct Crush
    {
        @Argument(help: "Where to find the WebAssembly (wasm) binary to crush",
            completion: .file(extensions: ["wasm"]))
        var wasmFile:FilePath?

        @Option(
            name: [.customLong("output", withSingleDash: true), .customShort("o")],
            help: "Where to write the optimized WebAssembly (wasm) binary",
            completion: .file(extensions: ["wasm"]))
        var wasmOutput:FilePath = "main.wasm"

        @Option(
            name: [.customLong("Xwasm-opt", withSingleDash: true)],
            parsing: .unconditionalSingleValue,
            help: "Extra flags to pass to the WebAssembly optimizer")
        var wasmOptimizerFlags:[String] = []

        @Flag(
            name: [.customLong("preserve-debug-info", withSingleDash: true), .customShort("g")],
            help: "Whether to preserve debug info or not")
        var preserveDebugInfo:Bool = false
    }
}
extension ArcherCommand.Crush:ParsableCommand
{
    mutating
    func run() throws
    {
        guard
        let wasmFile:FilePath = self.wasmFile?.lexicallyNormalized()
        else
        {
            print("""
                no wasm file provided!

                hint: \(Archer.hintBuild)
                """)
            Self.exit(withError: ExitCode.failure)
        }

        let crusher:Archer.Crusher = .init(
            wasmOptimizerFlags: self.wasmOptimizerFlags,
            preserveDebugInfo: self.preserveDebugInfo)

        if  try crusher.crush(wasm: wasmFile, into: wasmOutput)
        {
            print("output written to \(self.wasmOutput)")
        }
    }
}

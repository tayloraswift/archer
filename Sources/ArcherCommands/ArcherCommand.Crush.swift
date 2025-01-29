#if canImport(Darwin)
import func Darwin.exit
#elseif canImport(Glibc)
import func Glibc.exit
#endif

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
            name: [.customLong("output"), .customShort("o")],
            help: "Where to write the optimized WebAssembly (wasm) binary",
            completion: .file(extensions: ["wasm"]))
        var wasmOutput:FilePath

        @Option(
            name: [.customLong("Xwasm-opt")],
            parsing: .unconditionalSingleValue,
            help: "Extra flags to pass to the WebAssembly optimizer")
        var wasmOptimizerFlags:[String] = []

        @Flag(
            name: [.customShort("g"), .customLong("preserve-debug-info")],
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

                hint: swift build -c release \\
                    --product <product> \\
                    --swift-sdk <wasm sdk> \\
                    -Xswiftc -Xclang-linker -Xswiftc -mexec-model=reactor \\
                    -Xlinker --export=__main_argc_argv
                """)
            Self.exit(withError: ExitCode.failure)
        }

        let crusher:Archer.Crusher = .init(
            wasmOptimizerFlags: self.wasmOptimizerFlags,
            preserveDebugInfo: self.preserveDebugInfo)

        try crusher.crush(wasm: wasmFile, into: wasmOutput)

        print("output written to \(self.wasmOutput)")
    }
}

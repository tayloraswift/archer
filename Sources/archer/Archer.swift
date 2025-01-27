import ArgumentParser
import System_ArgumentParser
import SystemIO
import WasmTransformer

@main
struct ArcherCommand:AsyncParsableCommand
{
    @Argument(help: "The path to the WebAssembly (wasm) binary")
    var wasm:FilePath

    @Option(
        name: [.customLong("Xwasm-opt")],
        parsing: .unconditionalSingleValue,
        help: "Extra flags to pass to the WebAssembly optimizer")
    var wasm_opt:[String] = []

    @Flag(
        name: [.customShort("g"), .customLong("preserve-debug-info")],
        help: "Preserve debug info")
    var preserveDebugInfo:Bool = false

    func run() async throws
    {
        guard
        let basename:String = self.wasm.stem,
        let output:FilePath = .init(argument: "\(basename).optimized.wasm")
        else
        {
            throw ArcherCommandError.invalidPath
        }

        let unoptimized:FilePath
        if  self.preserveDebugInfo
        {
            unoptimized = self.wasm
        }
        else if
            let path:FilePath = .init(argument: "\(basename).stripped.wasm")
        {
            unoptimized = path

            let content:[UInt8] = try self.wasm.read()
            print("Loaded wasm: \(content.count / 1_000) KB")
            let stripped:[UInt8] = try stripCustomSections(content)

            print("After stripping debug info: \(stripped.count / 1_000) KB")
            try unoptimized.overwrite(with: stripped[...])
        }
        else
        {
            throw ArcherCommandError.invalidPath
        }

        let optimizer:SystemProcess = try .init(command: "wasm-opt",
            arguments: self.wasm_opt + [
                "-Os",
                "--enable-bulk-memory",
                "--enable-sign-ext",
                "\(unoptimized)",
                "-o", "\(output)",
            ],
            echo: true)

        try optimizer()
    }
}

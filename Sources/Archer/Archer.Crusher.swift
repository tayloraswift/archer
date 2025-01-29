import SystemIO
import WasmTransformer

extension Archer
{
    @frozen public
    struct Crusher
    {
        @usableFromInline
        var wasmOptimizerFlags:[String]
        @usableFromInline
        var preserveDebugInfo:Bool

        @inlinable public
        init(wasmOptimizerFlags:[String] = [], preserveDebugInfo:Bool = false)
        {
            self.wasmOptimizerFlags = wasmOptimizerFlags
            self.preserveDebugInfo = preserveDebugInfo
        }
    }
}
extension Archer.Crusher
{
    public
    func crush(wasm:FilePath,
        into output:FilePath,
        optimizerFlags:[String] = [],
        preserveDebugInfo:Bool = false) throws
    {
        let unoptimized:FilePath
        if  self.preserveDebugInfo
        {
            unoptimized = wasm
        }
        else
        {
            unoptimized = output

            let content:[UInt8] = try wasm.read()
            print("Loaded wasm: \(content.count / 1_000) KB")
            let stripped:[UInt8] = try stripCustomSections(content)

            print("After stripping debug info: \(stripped.count / 1_000) KB")
            try output.overwrite(with: stripped[...])
        }

        let optimizer:SystemProcess = try .init(command: "wasm-opt",
            arguments: self.wasmOptimizerFlags + [
                "-Os",
                "--enable-bulk-memory",
                "--enable-sign-ext",
                "\(unoptimized)",
                "-o", "\(output)",
            ],
            echo: true)

        try optimizer()

        let optimizedSize:Int = try output.open(.readOnly) {  try $0.length() }
        print("After optimization: \(optimizedSize / 1_000) KB")
    }
}

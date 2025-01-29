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
        preserveDebugInfo:Bool = false) throws -> Bool
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
            print("Size of original WebAssembly binary: \(Self.format(size: content.count))")
            let stripped:[UInt8] = try stripCustomSections(content)

            print("Size after stripping debug symbols: \(Self.format(size: stripped.count))")
            try output.overwrite(with: stripped[...])
        }

        let optimizer:SystemProcess
        do
        {
            optimizer = try .init(command: "wasm-opt",
                arguments: self.wasmOptimizerFlags + [
                    "-Os",
                    "--enable-bulk-memory",
                    "--enable-sign-ext",
                    "\(unoptimized)",
                    "-o", "\(output)",
                ],
                echo: true)
        }
        catch SystemProcessError.spawn(2, _)
        {
            print("""
                note: wasm-opt not found, skipping optimization
                hint: install the 'binaryen' package to enable optimizations
                """)
            return !self.preserveDebugInfo
        }

        try optimizer()

        let optimizedSize:Int = try output.open(.readOnly) {  try $0.length() }
        print("Size after optimization: \(Self.format(size: optimizedSize))")
        return true
    }

    private static
    var reset:String { "\u{1B}[39;5m" }

    private static
    var pink:String { "\u{1B}[38;5;205m" }

    private
    static func format(size:Int, colors:Bool = true) -> String
    {
        let (mb, b):(Int, remainder:Int) = size.quotientAndRemainder(dividingBy: 1_000_000)
        let (kb, _):(Int, remainder:Int) = b.quotientAndRemainder(dividingBy: 1_000)
        let dd:String = "\(kb / 10)"
        let text:String = "\(mb).\(String.init(repeating: "0", count: 2 - dd.count))\(dd) MB"
        return colors ? "\(Self.pink)\(text)\(Self.reset)" : text
    }
}

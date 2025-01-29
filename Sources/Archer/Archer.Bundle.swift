import SystemIO

extension Archer
{
    @frozen public
    struct Bundle
    {
        @usableFromInline
        let directory:FilePath.Directory

        @inlinable public
        init(directory:FilePath.Directory)
        {
            self.directory = directory
        }
    }
}
extension Archer.Bundle
{
    public
    func initialize(wasm:String = "main.wasm",
        javascript:String = "main.js",
        resources:FilePath.Directory) throws
    {
        let scratch:FilePath.Directory = self.directory / ".archer"
        try scratch.remove()
        try scratch.create()

        let cartonJS:FilePath = scratch / "carton.js"
        try cartonJS.overwrite(with: [_].init(_CartonResources.js(wasm: wasm).utf8)[...])

        let mainJS:FilePath = self.directory / javascript

        try SystemProcess.init(command: "cp", "-rf", "\(resources)", "\(scratch)")()
        try SystemProcess.init(command: "esbuild",
            arguments: [
                "--bundle",
                "\(cartonJS)",
                "--outfile=\(mainJS)",
                "--format=esm",
                "--minify",
            ],
            echo: true)()

        try scratch.remove()
    }
}

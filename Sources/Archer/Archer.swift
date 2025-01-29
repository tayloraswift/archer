public
enum Archer
{
    public
    static var hintBuild:String
    {
        """
        swift build -c release \\
            --product <product> \\
            --swift-sdk <wasm sdk> \\
            -Xswiftc -Xclang-linker -Xswiftc -mexec-model=reactor \\
            -Xlinker --export=__main_argc_argv
        """
    }
}

import ArgumentParser
import _GitVersion

extension ArcherCommand
{
    struct Version:ParsableCommand
    {
        mutating
        func run()
        {
            print(String.init(cString: _GitVersion.swiftpm_git_version()))
        }
    }
}

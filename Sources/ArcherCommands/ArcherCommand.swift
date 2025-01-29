import Archer
import ArgumentParser

@main
struct ArcherCommand:ParsableCommand
{
    static var configuration:CommandConfiguration
    {
        .init(commandName: "archer",
            subcommands: [
                Version.self,
                Crush.self,
                Init.self,
            ])
    }
}

import ArgumentParser
import Foundation

struct CrosswordTokenGenerator: ParsableCommand {

    @Argument(help: "The target platform.")
    var target: Target

    @Argument(help: "The path to a spreadsheet CSV export.")
    var csvPath: String

    func run() throws {
        let url = URL(fileURLWithPath: csvPath)
        let csv = try String(contentsOf: url)
        print(csv)
    }
}

enum Target: String, ExpressibleByArgument {
    case android, ios
}

CrosswordTokenGenerator.main()

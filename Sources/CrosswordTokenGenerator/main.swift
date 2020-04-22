import ArgumentParser
import Foundation

struct CrosswordTokenGenerator: ParsableCommand {

    @Argument(help: "The target platform. \(Target.allCaseNames)")
    var target: Target

    @Argument(help: "The path to a spreadsheet CSV export.")
    var path: String

    func run() throws {
        let url = URL(fileURLWithPath: path)
        let csv = try String(contentsOf: url)
        print(csv)
    }
}

enum Target: String, CaseIterable, ExpressibleByArgument {
    case android, ios
}

extension CaseIterable {
    static var allCaseNames: [String] {
        allCases.map { "\($0)" }
    }
}

CrosswordTokenGenerator.main()

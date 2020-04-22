import ArgumentParser
import CodableCSV
import Foundation

struct CrosswordTokenGenerator: ParsableCommand {

    @Argument(help: "The target platform. \(Target.allCaseNames)")
    var target: Target

    @Argument(help: "The path to a spreadsheet CSV export.")
    var path: String

    func run() throws {
        let url = URL(fileURLWithPath: path)
        let csvColors = try decodeCSV([CodableColor].self, from: url)
        print(csvColors.count)
    }
}

/// Decoding twice is wasteful, but I'll deal with that once it starts to costing real time.
func decodeCSV<T: Decodable & Collection>(_ type: T.Type, from url: URL) throws -> T {
    let crlfDecoder = CSVDecoder {
        $0.delimiters.row = "\r\n"
        $0.headerStrategy = .firstLine
    }
    let lfDecoder = CSVDecoder {
        $0.delimiters.row = "\n"
        $0.headerStrategy = .firstLine
    }
    let crlfValues = try crlfDecoder.decode(T.self, from: url)
    let lfValues = try lfDecoder.decode(T.self, from: url)
    return crlfValues.count > lfValues.count
        ? crlfValues
        : lfValues
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

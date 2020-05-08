import ArgumentParser
import CodableCSV
import Foundation

struct TokenGenerator: ParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "TokenGenerator",
        abstract: "A small program to turn design tokens into code.")

    @Argument(help: "The target platform. \(Target.allCaseNames)")
    var target: Target

    @OptionGroup() var sheets: SheetOptions

    func run() throws {

        if let path = sheets.semantic {
            let data = try Data(contentsOfPathOrURL: path)
            let csvColors = try decodeCSV([SemanticCodableColor].self, from: data)
            let colors = csvColors.map(SemanticColor.init)
            switch target {
            case .android:  print(androidXML(colors))
            case .ios:      print(iosSwift(colors))
            case .web:      print(webSCSS(colors))
            }
        }

        if sheets.semantic != nil && sheets.swatch != nil {
            print("")
        }

        if let path = sheets.swatch {
            let data = try Data(contentsOfPathOrURL: path)
            let csvColors = try decodeCSV([SwatchCodableColor].self, from: data)
            let colors = csvColors.map(SwatchColor.init)
            switch target {
            case .android:  print(androidXML(colors))
            case .ios:      print(iosSwift(colors))
            case .web:      print(webSCSS(colors))
            }
        }
    }
}

struct SheetOptions: ParsableArguments {

    @Option(help: "Location of the semantic colors. A URL or a local file is fine.")
    var semantic: String?

    @Option(help: "Location of the swatch colors. A URL or a local file is fine.")
    var swatch: String?

    func validate() throws {
        if semantic == nil && swatch == nil {
            throw ValidationError("Must provide at least one sheet location. Semantic, swatch, or both.")
        }
    }
}

/// Decoding twice is wasteful, but I'll deal with that once it starts to costing real time.
func decodeCSV<T: Decodable & Collection>(_ type: T.Type, from data: Data) throws -> T {
    let crlfDecoder = CSVDecoder {
        $0.delimiters.row = "\r\n"
        $0.headerStrategy = .firstLine
    }
    let lfDecoder = CSVDecoder {
        $0.delimiters.row = "\n"
        $0.headerStrategy = .firstLine
    }
    let crlfValues = try crlfDecoder.decode(T.self, from: data)
    let lfValues = try lfDecoder.decode(T.self, from: data)
    return crlfValues.count >= lfValues.count
        ? crlfValues
        : lfValues
}

enum Target: String, CaseIterable, ExpressibleByArgument {
    case android, ios, web
}

extension CaseIterable {
    static var allCaseNames: [String] {
        allCases.map { "\($0)" }
    }
}

TokenGenerator.main()

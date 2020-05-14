import ArgumentParser
import Foundation

struct SwatchColor {
    /// Any ol' name you want
    let name: String

    /// Normalized to 8 chars, e.g. '#33AA88FF'
    let hexColor: String
}

extension SwatchColor {

    init(_ cc: SwatchCodableColor) throws {
        name     = cc.name
        hexColor = try normalizedHexColor(raw: cc.hexColor, swatchName: cc.name)
    }

    var safeName: String {
        safeWord(raw: name)
    }
}

struct SwatchCodableColor: Decodable {
    let name     : String
    let hexColor : String?

    enum CodingKeys: String, CodingKey {
        case name     = "Name"
        case hexColor = "Hex Color"
    }
}

/// Expands hex color shorthands to our normalized format: # plus 8 chars uppercase,
/// e.g. '#33AA88FF'.
///
/// - Parameters:
///   - maybeRaw: Hex color as read from the external source.
///   - swatchName: Used to give the user a better error, if needed.
/// - Throws: ValidationError
/// - Returns: A hex color, normalized to # plus 8 chars uppercase, e.g. '#33AA88FF'.
private func normalizedHexColor(raw maybeRaw: String?, swatchName: String) throws -> String {
    guard let raw = maybeRaw, !raw.isEmpty else {
        throw ValidationError("Error in swatch '\(swatchName)': All colors must have hex values.")
    }

    let full: String = try {
        switch raw.count {
        case 4:
            // 3 char hex implies char duplication and 100% opaque
            return raw.map({ "\($0)\($0)" }).joined() + "FF"
        case 7:
            // 6 char hex implies 100% opaque
            return raw + "FF"
        case 9:
            return raw
        default:
            throw ValidationError("Error in swatch '\(swatchName)': Hex colors must be 3, 6 or 8 letters, excluding the leading '#'.")
        }
    }()

    return full.uppercased()
}

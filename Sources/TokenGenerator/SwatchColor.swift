import Foundation

struct SwatchColor {
    let name     : String
    let hexColor : String
}

extension SwatchColor {
    init(_ cc: SwatchCodableColor) {
        name     = cc.name
        hexColor = cc.hexColor ?? "MISSING"
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

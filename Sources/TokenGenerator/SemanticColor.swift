import Foundation

struct SemanticColor {
    let name              : String
    let lightHighContrast : String
    let lightNormal       : String
    let dark              : String
    let moreDescription   : String?
}

extension SemanticColor {

    init(_ cc: SemanticCodableColor) {
        name              = cc.name
        lightHighContrast = cc.lightHighContrast ?? "MISSING"
        lightNormal       = cc.lightNormal ?? "MISSING"
        dark              = cc.dark ?? "MISSING"
        moreDescription   = cc.moreDescription
    }

    var safeName: String {
        safeName(raw: name)
    }
}

struct SemanticCodableColor: Decodable {
    let name              : String
    let lightHighContrast : String?
    let lightNormal       : String?
    let dark              : String?
    let moreDescription   : String?

    enum CodingKeys: String, CodingKey {
        case name              = "Name"
        case lightHighContrast = "Light HighContrast"
        case lightNormal       = "Light Normal"
        case dark              = "Dark"
        case moreDescription   = "More Description"
    }
}

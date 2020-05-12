import Foundation

func iosSwift(_ semanticColors: [SemanticColor]?, _ swatchColors: [SwatchColor]?) -> String {
    """
    import Foundation
    
    \(swatchColors.map(swiftColors) ?? "")

    \(semanticColors.map(swiftColors) ?? "")
    """
}

private func swiftColors(_ colors: [SemanticColor]) -> String {
    """
    /// Semantic Colors
    /// -------------
    ///
    /// !!DO NOT MODIFY THIS FILE DIRECTLY!!
    ///
    /// The below colors are generated from an automated workflow that is shared
    /// between web, iOS, and Android platforms.

    extension XWDColor {

    \(colors.map(swiftColor).joined(separator: "\n\n"))
    
    }
    """
}

/// Since Swatch color names are "safe", references to them must also be "safe".
private func swiftColor(_ color: SemanticColor) -> String {
    let comment: String? = color.moreDescription.map {
        """
            // \($0)\n
        """
    }
    return (comment ?? "") +
        """
            @objc(\(color.safeName)Color)
            public class var \(color.safeName): UIColor {
                switch colorScheme {
                case .highContrast: return XWDColor.\(safeWord(raw: color.lightHighContrast))
                case .normal:       return XWDColor.\(safeWord(raw: color.lightNormal))
                case .dark:         return XWDColor.\(safeWord(raw: color.dark))
                }
            }
        """
}

private func swiftColors(_ colors: [SwatchColor]) -> String {
    """
    /// Swatch Colors
    /// -------------
    ///
    /// !!DO NOT MODIFY THIS FILE DIRECTLY!!
    ///
    /// The below colors are generated from an automated workflow that is shared
    /// between web, iOS, and Android platforms.

    // MARK: By Name

    private enum ColorName: String {
    \(colors.map { color in
    """
        case \(color.safeName) = "\(color.name)"
    """
    }.joined(separator: "\n"))
    }

    extension XWDColor {

    \(colors.map { color in
    """
        @objc(\(color.safeName)Color)
        public class var \(color.safeName): UIColor {
            return UIColor(rgbaValue: 0x\(color.hexColor.dropFirst()))
        }
    """
    }.joined(separator: "\n\n"))

    }

    extension XWDColor {

        /// Finds a color based on its *raw* name. For example, if the Swatch sheet has
        /// "black0.4", which generates `XWDColor.black04`, then you still want
        /// `XWDColor.color(byName: "black0.4")`
        @objc public class func color(byName name: String) -> UIColor? {
            guard let colorName = ColorName(rawValue: name) else { return nil }
            switch colorName {
    \(colors.map { color in
    """
            case .\(color.safeName): return XWDColor.\(color.safeName)
    """
    }.joined(separator: "\n"))
            }
        }

    }
    """
}

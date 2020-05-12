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
                case .highContrast: return XWDColor.\(safeName(raw: color.lightHighContrast))
                case .normal:       return XWDColor.\(safeName(raw: color.lightNormal))
                case .dark:         return XWDColor.\(safeName(raw: color.dark))
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

    private extension UIColor {
        convenience init(rgbaValue: UInt32) {
            let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
            let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
            let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
            let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        }

        class var random: UIColor {
            let h = CGFloat(arc4random_uniform(256)) / 255.0
            let s = CGFloat(arc4random_uniform(128)) / 127.0 + 128.0
            let b = CGFloat(arc4random_uniform(128)) / 127.0 + 128.0
            return self.init(hue: h, saturation: s, brightness: b, alpha: 1.0)
        }
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

    // MARK: By Name

    private enum ColorName: String {
    \(colors.map { color in
    """
        case \(color.safeName) = "\(color.name)"
    """
    }.joined(separator: "\n"))
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

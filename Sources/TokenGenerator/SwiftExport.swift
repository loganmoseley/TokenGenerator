import Foundation

func iosSwift(_ semanticColors: [SemanticColor]?, _ swatchColors: [SwatchColor]?) -> String {
    """
    import Foundation

    \(semanticColors.map(swiftColors) ?? "")

    \(swatchColors.map(swiftColors) ?? "")
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

private func swiftColor(_ color: SemanticColor) -> String {
    let comment: String? = color.moreDescription.map {
        """
            // \($0)\n
        """
    }
    return (comment ?? "") +
        """
            @objc(\(color.name)Color)
            public class var \(color.name): UIColor {
                switch colorScheme {
                case .highContrast: return XWDColor.\(color.lightHighContrast)
                case .normal:       return XWDColor.\(color.lightNormal)
                case .dark:         return XWDColor.\(color.dark)
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

    \(colors.map(swiftColor).joined(separator: "\n\n"))

    }
    """
}

private func swiftColor(_ color: SwatchColor) -> String {
    // replace non-alphanumerics with "_"
    let alphanumericName = color.name
        .map { (c: Character) -> String in
            let s = CharacterSet(charactersIn: String(c))
            return CharacterSet.alphanumerics.isSuperset(of: s)
                ? String(c)
                : "_"
        }
        .joined()

    let name = (alphanumericName.first?.isLetter ?? false)
        ? alphanumericName
        : "_" + alphanumericName

    return
        """
            @objc(\(name)Color)
            public class var \(name): UIColor {
                return UIColor(rgbaValue: 0x\(color.hexColor.dropFirst()))
            }
        """
}

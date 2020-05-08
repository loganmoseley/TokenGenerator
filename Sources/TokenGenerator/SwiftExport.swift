import Foundation

func iosSwift(_ colors: [SemanticColor]) -> String {
    """
    /// Semantic Colors
    /// -------------
    ///
    /// !!DO NOT MODIFY THIS FILE DIRECTLY!!
    ///
    /// The below colors are generated from an automated workflow that is shared
    /// between web, iOS, and Android platforms.

    extension XWDColor {

    \(colors.map(swiftSemanticColor).joined(separator: "\n\n"))
    
    }
    """
}

private func swiftSemanticColor(_ color: SemanticColor) -> String {
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

import Foundation

func iosSwift(_ colors: [SemanticColor]) -> String {
    """
    import Foundation

    extension XWDColor {

    \(colors
        .map(swiftSemanticColor)
        .joined(separator: "\n\n"))
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
            @objc(\(color.name)Color) public class var \(color.name): UIColor {
                switch colorScheme {
                case .highContrast: return XWDColor.\(color.lightHighContrast)
                case .normal:       return XWDColor.\(color.lightNormal)
                case .dark:         return XWDColor.\(color.dark)
                }
            }
        """
}

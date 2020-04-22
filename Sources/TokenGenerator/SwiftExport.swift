import Foundation

func iosSwift(_ colors: [Color]) -> String {
    """
    import Foundation

    extension XWDColor {

    \(colors
        .map(swiftOneColor)
        .joined(separator: "\n\n"))
    }
    """
}

private func swiftOneColor(_ color: Color) -> String {
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

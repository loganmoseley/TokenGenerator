import Foundation

func androidXML(_ semanticColors: [SemanticColor]?, _ swatchColors: [SwatchColor]?) -> String {
    """
    <?xml version="1.0" encoding="utf-8"?>
    <resources>

    \(semanticColors.map(xmlColors) ?? "")

    \(swatchColors.map(xmlColors) ?? "")

    </resources>
    """
}

private func xmlColors(_ colors: [SemanticColor]) -> String {
    colors
        .map(xmlColor)
        .joined(separator: "\n\n")
}

private func xmlColor(_ color: SemanticColor) -> String {
    """
        <color name="\(color.name)">@android:color/\(color.lightNormal)</color>
        <color name="\(color.name)HC">@android:color/\(color.lightHighContrast)</color>
        <color name="\(color.name)Dark">@android:color/\(color.dark)</color>
    """
}

private func xmlColors(_ colors: [SwatchColor]) -> String {
    colors
        .map(xmlColor)
        .joined(separator: "\n")
}

private func xmlColor(_ color: SwatchColor) -> String {
    """
        <color name="\(color.name)">\(color.hexColor)</color>
    """
}

import Foundation

func androidXML(_ semanticColors: [SemanticColor]?, _ swatchColors: [SwatchColor]?) -> String {
    """
    <?xml version="1.0" encoding="utf-8"?>
    <resources>

    \(swatchColors.map(xmlColors) ?? "")

    \(semanticColors.map(xmlColors) ?? "")

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
        <color name="\(color.safeName)">@android:color/\(safeWord(raw: color.lightNormal))</color>
        <color name="\(color.safeName)HC">@android:color/\(safeWord(raw: color.lightHighContrast))</color>
        <color name="\(color.safeName)Dark">@android:color/\(safeWord(raw: color.dark))</color>
    """
}

private func xmlColors(_ colors: [SwatchColor]) -> String {
    colors
        .map(xmlColor)
        .joined(separator: "\n")
}

private func xmlColor(_ color: SwatchColor) -> String {
    """
        <color name="\(color.safeName)">\(color.hexColor)</color>
    """
}

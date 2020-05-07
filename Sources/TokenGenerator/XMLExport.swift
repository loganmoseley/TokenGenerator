import Foundation

func androidXML(_ colors: [SemanticColor]) -> String {
    """
    <?xml version="1.0" encoding="utf-8"?>
    <resources>

    \(colors
        .map(xmlOneColor)
        .joined(separator: "\n\n"))

    </resources>
    """
}

private func xmlOneColor(_ color: SemanticColor) -> String {
    """
        <color name="\(color.name)">@android:color/\(color.lightNormal)</color>
        <color name="\(color.name)HC">@android:color/\(color.lightHighContrast)</color>
        <color name="\(color.name)Dark">@android:color/\(color.dark)</color>
    """
}

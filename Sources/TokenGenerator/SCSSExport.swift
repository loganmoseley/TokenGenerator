import Foundation

/// Based on https://github.com/nytm/games-phoenix/blob/8d0f729364f342a45e58daddff5495d12d2a92db/src/shared/scss-helpers/colors.scss
func webSCSS(_ colors: [SemanticColor]) -> String {
    colors
        .map(scssOneColor)
        .joined(separator: "\n\n")
}

private func scssOneColor(_ color: SemanticColor) -> String {
    """
    $\(color.name): $\(color.lightNormal);
    $\(color.name)HC: $\(color.lightHighContrast);
    $\(color.name)Dark: $\(color.dark);
    """
}

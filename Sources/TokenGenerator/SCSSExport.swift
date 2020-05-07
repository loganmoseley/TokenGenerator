import Foundation

/// Based on https://github.com/nytm/games-phoenix/blob/8d0f729364f342a45e58daddff5495d12d2a92db/src/shared/scss-helpers/colors.scss
func webSCSS(_ colors: [SemanticColor]) -> String {
    """
    /// Semantic Colors
    /// -------------
    ///
    /// !!DO NOT MODIFY THIS FILE DIRECTLY!!
    ///
    /// The below colors are generated from an automated workflow that is shared
    /// between web, iOS, and Android platforms.

    \(colors.map {
    """
    $\($0.name): $\($0.lightNormal);
    $\($0.name)HC: $\($0.lightHighContrast);
    $\($0.name)Dark: $\($0.dark);
    """
    }.joined(separator: "\n\n"))
    """
}

func webSCSS(_ colors: [SwatchColor]) -> String {
    """
    /// Swatch Colors
    /// -------------
    ///
    /// !!DO NOT MODIFY THIS FILE DIRECTLY!!
    ///
    /// The below colors are generated from an automated workflow that is shared
    /// between web, iOS, and Android platforms.

    \(colors
        .map { "$\($0.name): \($0.hexColor);" }
        .joined(separator: "\n"))
    """
}

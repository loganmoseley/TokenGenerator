import Foundation

/// Maps an arbitrary string to one that follows language conventions for variable names.
/// For example, a Swift variable cannot start with a number.
///
/// If language rules differ, choose a heuristic that best fits all.
func safeWord(raw: String) -> String {
    prefixUnderscore(forceAlphanumeric(raw: raw))
}

/// Replace non-alphanumerics with underscores.
func forceAlphanumeric(raw: String) -> String {
    raw.map { (c: Character) -> String in
        let s = CharacterSet(charactersIn: String(c))
        return CharacterSet.alphanumerics.isSuperset(of: s)
            ? String(c)
            : "_"
    }
    .joined()
}

/// Prefix with underscore if it doesn't start with a letter.
func prefixUnderscore(_ str: String) -> String {
    (str.first?.isLetter ?? false)
        ? str
        : "_" + str
}

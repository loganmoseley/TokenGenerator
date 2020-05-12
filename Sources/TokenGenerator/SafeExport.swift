import Foundation

/// Maps an arbitrary string to one that follows language conventions for variable names.
/// For example, a Swift variable cannot start with a number.
///
/// If language rules differ, choose a heuristic that best fits all.
func safeName(raw: String) -> String {
    // replace non-alphanumerics with "_"
    let alphanumericName = raw
        .map { (c: Character) -> String in
            let s = CharacterSet(charactersIn: String(c))
            return CharacterSet.alphanumerics.isSuperset(of: s)
                ? String(c)
                : "_"
        }
        .joined()

    // prefix with underscore if it doesn't start with a letter
    let name = (alphanumericName.first?.isLetter ?? false)
        ? alphanumericName
        : "_" + alphanumericName

    return name
}

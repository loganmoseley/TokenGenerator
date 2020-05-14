import ArgumentParser
import Foundation

extension Data {
    /// NSCocoaErrorDomain's "File" error codes:
    ///
    ///     4:   "NSFileNoSuchFileError",
    ///     255: "NSFileLockingError",
    ///     256: "NSFileReadUnknownError",
    ///     257: "NSFileReadNoPermissionError",
    ///     258: "NSFileReadInvalidFileNameError",
    ///     259: "NSFileReadCorruptFileError",
    ///     260: "NSFileReadNoSuchFileError",
    ///     261: "NSFileReadInapplicableStringEncodingError",
    ///     262: "NSFileReadUnsupportedSchemeError",
    ///     263: "NSFileReadTooLargeError",
    ///     264: "NSFileReadUnknownStringEncodingError",
    ///     512: "NSFileWriteUnknownError",
    ///     513: "NSFileWriteNoPermissionError",
    ///     514: "NSFileWriteInvalidFileNameError"
    ///     516: "NSFileWriteFileExistsError",
    ///     517: "NSFileWriteInapplicableStringEncodingError",
    ///     518: "NSFileWriteUnsupportedSchemeError",
    ///     640: "NSFileWriteOutOfSpaceError",
    ///     642: "NSFileWriteVolumeReadOnlyError"
    ///
    init(contentsOfPathOrURL str: String) throws {
        guard let url = URL(string: str) else {
            throw ValidationError("Must provide a valid file path or URL.")
        }
        do {
            self = try Data(contentsOf: url)
        }
        catch {
            let nsError = error as NSError
            if nsError.domain == NSCocoaErrorDomain && nsError.code == NSFileReadUnknownError  {
                self = try Data(contentsOf: URL(fileURLWithPath: str))
            }
            else {
                throw error
            }
        }
    }
}

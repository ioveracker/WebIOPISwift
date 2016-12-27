import Foundation

/// Represents the status of a response from the WebIOPi REST API.
public enum Status {

    /// No errors. (200)
    case ok

    /// The request was invalid. (400)
    case badRequest

    /// The requested pin is unavailable. (403)
    case pinUnavailable

    /// The requested pin was not found. (404)
    case notFound

    /// Failed to parse response from WebIOPi REST API.
    case parseError

    /// Attempts to create a Status object from the given HTTP status code.
    ///
    /// - parameter code: An HTTP status code.
    public static func makeFromHTTPStatusCode(code: Int) -> Status? {
        if code == 200 {
            return .ok
        } else if code == 400 {
            return .badRequest
        } else if code == 403 {
            return .pinUnavailable
        } else if code == 404 {
            return .notFound
        }

        return nil
    }

}

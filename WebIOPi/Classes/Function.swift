import Foundation

/// Pin function options.
public enum Function {

    /// Input
    case `in`

    /// Output
    case out

    case alt0

    /// Returns all of the available Function cases.
    public static var all: [Function] {
        return [.in, .out, .alt0]
    }

    /// Attempts to create a Function from the given string.
    ///
    /// - parameter string: The string representing a Function.
    public static func makeFromString(string: String) -> Function? {
        if string == "IN" {
            return .in
        } else if string == "OUT" {
            return .out
        } else if string == "ALT0" {
            return .alt0
        }

        return nil
    }

}

import Foundation

/// Pin output options.
public enum Value {

    /// Turn the pin on (HIGH).
    case on

    /// Turn the pin off (LOW).
    case off

    var intValue: Int {
        switch self {
        case .on:
            return 1
        case .off:
            return 0
        }
    }

    /// Attempts to create a Value from the given Int.
    public static func makeFromInt(int: Int) -> Value? {
        if int == 0 {
            return .off
        } else if int == 1 {
            return .on
        }

        return nil
    }

    public func toggled() -> Value {
        switch self {
        case .on:
            return .off
        case .off:
            return .on
        }
    }

}

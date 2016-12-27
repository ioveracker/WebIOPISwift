import Foundation

public class WebIOPi {

    // The Raspberry Pi URL.
    public let host: String

    /// Provides access to the GPIO header on the Raspberry Pi.
    public let GPIO: GPIOType

    /// Creates a new `WebIOPi` instance configured to communicate with the given host.
    ///
    /// - parameter host: The Raspberry Pi URL.
    public init(host: String) {
        self.host = host
        self.GPIO = GPIOType(host: host)
    }

}

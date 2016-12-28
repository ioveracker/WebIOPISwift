import Foundation

/// The state / configuration of a GPIO pin.
public struct GPIOPin {

    /// The pin number.
    public let number: Int

    // The current value of the pin.
    public let value: Value?

    // The current function of the pin.
    public let function: Function?
    
}

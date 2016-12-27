import Foundation

/// The state / configuration of a GPIO pin.
public struct GPIOPin {

    // The current value of the pin.
    let value: Value?

    // The current function of the pin.
    let function: Function?
    
}

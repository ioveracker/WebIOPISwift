import Foundation

/// The state / configuration of a GPIO pin.
public class GPIOPin {

    public let pi: WebIOPi

    /// The pin number.
    public let number: Int

    // The current function of the pin.
    public private(set) var function: Function?

    // The current value of the pin.
    public private(set) var value: Value?

    public init(pi: WebIOPi, number: Int, function: Function, value: Value) {
        self.pi = pi
        self.number = number
        self.function = function
        self.value = value
    }

    public func changeFunction(to function: Function,
                                        completion: @escaping ((Status) -> Void)) {
        pi.GPIO.setFunction(function, pin: number) { status in
            if status == .ok {
                self.function = function
            }

            completion(status)
        }
    }

    public func changeValue(to value: Value,
                            completion: @escaping ((Status) -> Void)) {
        pi.GPIO.setValue(value, pin: number) { status in
            if status == .ok {
                self.value = value
            }

            completion(status)
        }
    }

    public func pulse(completion: @escaping ((Status) -> Void)) {
        pi.GPIO.pulse(pin: number) { status in
            completion(status)
        }
    }

    public func runSequence(_ sequence: [Value], delay: Int, completion: @escaping ((Status) -> Void)) {
        pi.GPIO.runSequence(sequence, delay: delay, pin: number) { status in
            completion(status)
        }
    }

}

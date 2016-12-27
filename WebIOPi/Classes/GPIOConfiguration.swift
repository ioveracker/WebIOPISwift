import Foundation

/// The configuration of the GPIO header on the Raspberry Pi.
public struct GPIOConfiguration {

    let oneWire: Int?
    let SPI: Int?
    let I2C: Int?
    let UART: Int?
    let GPIOPins: [Int: GPIOPin]

    /// Initializes a new `GPIOConfiguration` object populated with values from the given JSON.
    ///
    /// - parameter json: A dictionary containing GPIO configuration JSON.
    init(json: [String: Any]) {
        var pins = [Int: GPIOPin]()
        let gpio = json["GPIO"]
        if let gpioDictionary = json["GPIO"] as? [String: [String: Any]] {
            for (pinNumberString, details) in gpioDictionary {
                guard let
                    pinNumber = Int(pinNumberString),
                    let value = details["value"] as? Int,
                    let function = details["function"] as? String
                    else {
                        continue
                }

                pins[pinNumber] = GPIOPin(
                    value: Value.makeFromInt(int: value),
                    function: Function.makeFromString(string: function))
            }
        }

        GPIOPins = pins
        oneWire = json["ONEWIRE"] as? Int
        SPI = json["SPI"] as? Int
        I2C = json["I2C"] as? Int
        UART = json["UART"] as? Int
    }
    
}

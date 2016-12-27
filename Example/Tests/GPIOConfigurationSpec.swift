import Quick
import Nimble
@testable import WebIOPi

class GPIOConfigurationSpec: QuickSpec {

    override func spec() {
        describe("A GPIOConfiguration") {
            it("can be created from valid JSON") {
                let validJSON = sampleJSON(filename: "GPIOConfiguration-Valid")
                let gpioConfig = GPIOConfiguration(json: validJSON)

                expect(gpioConfig).toNot(beNil())
                expect(gpioConfig.I2C) == 0
                expect(gpioConfig.oneWire) == 0
                expect(gpioConfig.SPI) == 0
                expect(gpioConfig.UART) == 1

                expect(gpioConfig.GPIOPins.count) == 54

                if let pin50 = gpioConfig.GPIOPins[50] {
                    expect(pin50.function) == .alt0
                    expect(pin50.value) == .on
                } else {
                    XCTFail("Failed to get pin 50.")
                }
            }
        }
    }

}

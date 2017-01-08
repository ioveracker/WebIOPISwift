# WebIOPi

[![Build Status](https://travis-ci.org/ioveracker/WebIOPiSwift.svg?branch=master)](https://travis-ci.org/ioveracker/WebIOPiSwift)
[![Version](https://img.shields.io/cocoapods/v/WebIOPi.svg?style=flat)](http://cocoapods.org/pods/WebIOPi)
[![License](https://img.shields.io/cocoapods/l/WebIOPi.svg?style=flat)](http://cocoapods.org/pods/WebIOPi)
[![Platform](https://img.shields.io/cocoapods/p/WebIOPi.svg?style=flat)](http://cocoapods.org/pods/WebIOPi)
[![Swift Version](https://img.shields.io/badge/Swift-3.0.x-orange.svg)]()

WebIOPiSwift is a Swift 3 library that wraps the WebIOPi REST API in a nice Swift package. It makes communicating with the GPIO pins on your Raspberry Pi from Swift code simple.

## Example

```swift
let pi = WebIOPi(host: "http://raspberrypi.local:8000")
pi.GPIO.setFunction(.out, pin: 3) { status in
  if status == .ok {
    pi.GPIO.setValue(.on, pin: 3) { status in
      if status == .ok {
        print("Pin 3 is now outputting a HIGH signal.")
      }
    }
  }
}
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

A Raspberry Pi running [WebIOPi](http://webiopi.trouch.com/INSTALL.html).

## Installation

WebIOPi is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WebIOPi"
```

## Roadmap

### v0.1.0 (Current)
Basic GPIO functions.
- [x] Get GPIO configuration
- [x] Get and set pin function
- [x] Get and set pin value
- [x] Send pulse to a pin
- [x] Send a bit sequence to a pin

### v1.0.0 (Future)
All API calls exposed.
- [ ] PWM
- [ ] Macros
- [ ] Better error handling


## Author

[Isaac Overacker](https://twitter.com/ioveracker)

## License

WebIOPi is available under the MIT license. See the LICENSE file for more info.

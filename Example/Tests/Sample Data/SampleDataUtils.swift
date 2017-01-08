//
//  SampleDataUtils.swift
//  WebIOPi
//
//  Created by Isaac Overacker on 12/26/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

func sampleJSON(filename: String) -> [String: Any] {
    let bundle = Bundle(for: GPIOConfigurationSpec.self)
    guard let url = bundle.url(forResource: filename, withExtension: "json") else {
        fatalError("Failed to load url for resource: \(filename)")
    }

    do {
        let data = try Data(contentsOf: url)
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            return json
        }
    } catch {
        print("Failed to load sample data: \(filename)")
    }

    return [:]
}

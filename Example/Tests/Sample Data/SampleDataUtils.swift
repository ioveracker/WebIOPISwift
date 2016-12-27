//
//  SampleDataUtils.swift
//  WebIOPi
//
//  Created by Isaac Overacker on 12/26/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

func sampleJSON(filename: String) -> [String: Any] {
    let path = Bundle.main.path(forResource: filename, ofType: "json")
    let url = URL(fileURLWithPath: path!)
    // swiftlint:disable:next force_try
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

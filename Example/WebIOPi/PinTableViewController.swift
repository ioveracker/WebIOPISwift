//
//  PinTableViewController.swift
//  WebIOPi
//
//  Created by Isaac Overacker on 12/29/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import WebIOPi

class PinTableViewController: UITableViewController {

    /// The GPIO pin presented by this view controller.
    var pin: GPIOPin? {
        didSet {
            if let pin = pin {
                title = "GPIO Pin \(pin.number)"
                tableView.reloadData()
            }
        }
    }

    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pin = pin else {
            return UITableViewCell()
        }

        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinCell")!

        if row == 0 {
            cell.textLabel?.text = "Function"
            cell.detailTextLabel?.text = "\(pin.function!)"
        } else if row == 1 {
            cell.textLabel?.text = "Value"
            cell.detailTextLabel?.text = "\(pin.value!)"
        }

        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row

        if row == 0 {
            let actionSheet = UIAlertController(
                title: "Select function",
                message: nil,
                preferredStyle: .actionSheet)

            for fn in Function.all {
                actionSheet.addAction(
                    UIAlertAction(
                        title: "\(fn)",
                        style: .default,
                        handler: { (action) in
                            self.newFunctionSelected(function: fn)
                            tableView.deselectRow(at: indexPath, animated: true)
                    }))
            }

            actionSheet.addAction(
                UIAlertAction(
                    title: "Cancel",
                    style: .cancel,
                    handler: { _ in
                        tableView.deselectRow(at: indexPath, animated: true)
                }))

            present(actionSheet, animated: true, completion: nil)
        } else if row == 1 {
            toggleValue()
        }
    }

}

private extension PinTableViewController {

    func newFunctionSelected(function: Function) {
        guard let pin = pin else {
            return
        }

        print("New function selected: \(function)")
//        pin.function = function
    }

    func toggleValue() {
        guard let oldValue = pin?.value else {
            return
        }

        print("Toggled value. \(oldValue) -> \(oldValue.toggled())")
    }

}

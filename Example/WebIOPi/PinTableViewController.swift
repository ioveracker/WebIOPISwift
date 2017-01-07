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

    var sequenceTextField: UITextField?
    var delayTextField: UITextField?

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
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 3
        }

        return 0
    }

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "General Info"
        } else if section == 1 {
            return "Pulse"
        } else if section == 2 {
            return "Bit Sequence"
        }

        return nil
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pin = pin else {
            return UITableViewCell()
        }

        let section = indexPath.section
        let row = indexPath.row

        var cell: UITableViewCell!

        if section == 0 {
            if row == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "PinCell")!
                cell.textLabel?.text = "Function"
                cell.detailTextLabel?.text = "\(pin.function!)"
            } else if row == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "PinCell")!
                cell.textLabel?.text = "Value"
                cell.detailTextLabel?.text = "\(pin.value!)"
            }
        } else if section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "PulseCell")!
        } else if section == 2 {
            if row == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "SequenceCell")!
                sequenceTextField = cell.contentView.subviews.first as? UITextField
            } else if row == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "DelayCell")!
                delayTextField = cell.contentView.subviews.first as? UITextField
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "SendSequenceCell")!
            }
        }

        return cell ?? UITableViewCell()
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row

        if section == 0 {
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
                        }))
                }

                actionSheet.addAction(
                    UIAlertAction(
                        title: "Cancel",
                        style: .cancel,
                        handler: nil))

                present(actionSheet, animated: true, completion: nil)
            } else if row == 1 {
                toggleValue()
            }
        } else if section == 1 {
            sendPulse()
        } else if section == 2 {
            if row == 2 {
                sendSequence()
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

}

private extension PinTableViewController {

    func newFunctionSelected(function: Function) {
        guard let pin = pin else {
            return
        }

        pin.changeFunction(to: function) { status in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func toggleValue() {
        guard let pin = pin else {
            return
        }

        pin.changeValue(to: pin.value!.toggled()) { status in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func sendPulse() {
        guard let pin = pin else {
            return
        }

        pin.pulse { (status) in
        }
    }

    func sendSequence() {
        guard let pin = pin,
              let delayText = delayTextField?.text,
              let delay = Int(delayText),
              let sequenceText = sequenceTextField?.text else {
            return
        }

        var sequence = [Value]()
        for index in sequenceText.characters.indices {
            let character = sequenceText[index]
            let string = String(character)

            if let int = Int(string), let value = Value.makeFromInt(int: int) {
                sequence.append(value)
            }
        }

        pin.runSequence(sequence, delay: delay) { status in
            print("ran sequence. status: \(status)")
        }
    }

}

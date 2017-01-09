//
//  GPIOTableViewController.swift
//  WebIOPi
//
//  Created by Isaac Overacker on 12/27/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import WebIOPi

class GPIOTableViewController: UITableViewController {

    var pi: WebIOPi?
    var GPIOConfiguration: GPIOConfiguration?
    var pins = [GPIOPin]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let pi = pi else {
            fatalError("No pi available when view was presented.")
        }

        title = pi.host

        pi.GPIO.getConfiguration() { status, config in
            guard let config = config else {
                let alert = UIAlertController(
                    title: "Uh oh!",
                    message: "Failed to get configuration for '\(pi.host)'. (\(status))",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }

            self.GPIOConfiguration = config
            self.pins = Array(config.GPIOPins.values).sorted(by: { $0.number < $1.number })

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pinController = segue.destination as? PinTableViewController {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                pinController.pin = pins[indexPath.row]
            }
        }
    }

    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "General Info"
        } else if section == 1 {
            return "Pins"
        }

        return nil
    }

    let numberOfGeneralInfoCells = 4
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard GPIOConfiguration != nil else {
            return 0
        }

        if section == 0 {
            return numberOfGeneralInfoCells
        } else if section == 1 {
            return pins.count
        }

        return 0
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let config = GPIOConfiguration else {
            return UITableViewCell()
        }

        let section = indexPath.section
        let row = indexPath.row

        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralInfoCell")!

            if row == 0 {
                cell.displayGeneralInfo(name: "I2C", value: config.I2C)
            } else if row == 1 {
                cell.displayGeneralInfo(name: "ONEWIRE", value: config.oneWire)
            } else if row == 2 {
                cell.displayGeneralInfo(name: "SPI", value: config.SPI)
            } else if row == 3 {
                cell.displayGeneralInfo(name: "UART", value: config.UART)
            }

            return cell
        } else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PinCell")!
            cell.displayPin(self.pins[row])
            return cell
        }

        return UITableViewCell()
    }

}

fileprivate extension UITableViewCell {

    func displayGeneralInfo(name: String, value: Int?) {
        textLabel?.text = name
        if let value = value {
            detailTextLabel?.text = "\(value)"
        } else {
            detailTextLabel?.text = "Unknown"
        }
    }

    func displayPin(_ pin: GPIOPin) {
        textLabel?.text = "\(pin.number)"

        if let function = pin.function, let value = pin.value {
            detailTextLabel?.text = "\(function), \(value)"
        } else {
            detailTextLabel?.text = "Unknown"
        }
    }

}

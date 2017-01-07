//
//  HostsTableViewController.swift
//  WebIOPi
//
//  Created by Isaac Overacker on 12/27/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import WebIOPi

class HostsTableViewController: UITableViewController {

    fileprivate var hosts = [WebIOPi(host: "http://192.168.1.120:8000")]
    fileprivate var selectedHost: WebIOPi?

    @IBAction func addHostButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "Add Host",
            message: nil,
            preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { action in
            if let textField = alert.textFields?.first {
                let host = textField.text!

                guard !self.hosts.contains(where: { $0.host == host }) else {
                    let duplicateAlert = UIAlertController(
                        title: "Duplicate Host",
                        message: "Host '\(host)' already exists.",
                        preferredStyle: .alert)
                    duplicateAlert.addAction(
                        UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(duplicateAlert, animated: true, completion: nil)
                    return
                }

                self.addHost(host: host)
            }
        })

        alert.addTextField() { textField in
            textField.placeholder = "Host URL"
        }

        present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gpioController = segue.destination as? GPIOTableViewController {
            if let cell = sender as? UITableViewCell,
               let indexPath = tableView.indexPath(for: cell) {
                gpioController.pi = hosts[indexPath.row]
            }
        }
    }

    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hosts.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HostCell")!
        cell.textLabel?.text = hosts[indexPath.row].host
        return cell
    }

}

fileprivate extension HostsTableViewController {

    func addHost(host: String) {
        hosts.append(WebIOPi(host: host))
        tableView.reloadData()
    }

}

//
//  TableViewController.swift
//  IBeacon
//
//  Created by Nick Ivanov on 28.09.2020.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UITextFieldDelegate, BeaconMonitorDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private var monitor: BeaconMonitor?
    
    @IBOutlet weak var uuidTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        
        if let uuidString = uuidTextField.text, let uuid = UUID(uuidString: uuidString) {
            print(uuid.uuidString)
            monitor = BeaconMonitor(uuid: uuid)
            monitor?.delegate = self
            monitor?.startListening()
    }
}
    
    var allBeacons: [CLBeacon]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.reloadData()
    }
    
   public func receivedAllBeacons(_ monitor: BeaconMonitor, beacons: [CLBeacon]) {
    
        print("All Beacons: \(beacons)")
        
        allBeacons = beacons
    
   }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let detaiVC = segue.destination as? DetailViewController else { return }
            guard let indexPathForSelectedRow = tableView.indexPathForSelectedRow else { return }
            detaiVC.currentBeacon = allBeacons?[indexPathForSelectedRow.row]
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        if let beacon = allBeacons?[indexPath.row] {
            cell.minorLabel.text = "Minor: \(beacon.minor.stringValue)"
            cell.majorLabel.text = "Major: \(beacon.major.stringValue)"
            cell.distanceLabel.text = "Distance: \(String(format: "%.2f", beacon.accuracy)) м."
            cell.rssiLabel.text = "RSSI: \(String(describing: beacon.rssi))"
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = allBeacons?.count else {
            return 0
        }
        return count
    }
}


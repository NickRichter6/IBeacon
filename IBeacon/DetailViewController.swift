//
//  DetailViewController.swift
//  IBeacon
//
//  Created by Nick Ivanov on 02.10.2020.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {
    
    var currentBeacon: CLBeacon?
    
    @IBOutlet weak var uuidDetailLabel: UILabel!
    @IBOutlet weak var majorDetailLabel: UILabel!
    @IBOutlet weak var minorDetailLabel: UILabel!
    @IBOutlet weak var distanceDetailLabel: UILabel!
    @IBOutlet weak var rssiDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uuidDetailLabel.text = currentBeacon?.uuid.uuidString
        majorDetailLabel.text = currentBeacon?.major.stringValue
        minorDetailLabel.text = currentBeacon?.minor.stringValue
        distanceDetailLabel.text = "\(String(format: "%.2f", currentBeacon!.accuracy)) м."
        rssiDetailLabel.text = "\(String(describing: currentBeacon!.rssi))"
    }
}

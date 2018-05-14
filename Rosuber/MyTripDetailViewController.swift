//
//  TripDetailViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/24.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import Firebase

class MyTripDetailViewController: TripDetailViewController {
    let myDetailToMySegueIdentifier = "myDetailToMySegue"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func leaveTrip(currentUid: String, actionController: UIAlertController) {
        if trip.time > Date() {
        actionController.addAction(UIAlertAction(title: "Leave", style: .destructive, handler: { _ in
                        let alertController = UIAlertController(title: "Are you sure you want to leave this trip?", message: "", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        alertController.addAction(UIAlertAction(title: "Leave", style: .destructive, handler: { _ in
                            self.leave(currentUid: currentUid)
                        }))
                        self.present(alertController, animated: true)
                    }))
        }
    }
    
    func leave(currentUid: String) {
        if (trip.driverKey == currentUid) {
            trip.driverKey = ""
        } else {
            trip.remove(passenger: currentUid)
        }
        if (trip.driverKey == "" && trip.passengersString == "") {
            let alertController = UIAlertController(title: "No occupants registered for this trip. This trip will be deleted.", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {_ in
                self.tripRef.delete()
                self.performSegue(withIdentifier: self.myDetailToMySegueIdentifier, sender: nil)
            }))
            self.present(alertController, animated: true)
        } else {
            tripRef.setData(trip.data)
        }
        updateView()
    }
}

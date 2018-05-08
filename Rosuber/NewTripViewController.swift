//
//  NewTripViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/26.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import Firebase

class NewTripViewController: UIViewController {
    let createToFindSegueIdentifier = "createToFindSegue"
    
    var newTrip: Trip!
    var tripRef: DocumentReference!
    
    @IBOutlet weak var driverSwitch: UISwitch!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var capacityField: UILabel!
    @IBOutlet weak var capacitySlider: UISlider!
    @IBOutlet weak var priceField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.capacitySlider.value = 1
        updateView()
    }
    
    @IBAction func pressedDone(_ sender: Any) {
        newTrip = Trip(isDriver: driverSwitch.isOn,
                       capacity: Int(self.capacitySlider.value),
                       destination: toField.text!,
                       origin: fromField.text!,
                       price: (Float(priceField.text!)! * 100).rounded() / 100,
                       time: datePicker.date)
        tripRef = Firestore.firestore().collection("trips").addDocument(data: newTrip.data) { (error) in
            if let error = error {
                print("Error when add document to firestore. Error: \(error.localizedDescription)")
                return
            }
            self.newTrip.id = self.tripRef.documentID
        }
    }
    
    @IBAction func changedSlider(_ sender: Any) {
        let fixed = roundf(capacitySlider.value / 1.0) * 1.0;
        capacitySlider.setValue(fixed, animated: true)
        updateView()
    }
    
    func updateView() {
        if Int(capacitySlider.value) == 1 {
            capacityField.text = "1 passenger"
        } else {
            capacityField.text = "\(Int(capacitySlider.value)) passengers"
        }
    }

}

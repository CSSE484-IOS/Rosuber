//
//  NewTripViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/26.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {
    @IBOutlet weak var driverSwitch: UISwitch!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var capacityField: UILabel!
    @IBOutlet weak var capacitySlider: UISlider!
    @IBOutlet weak var priceField: UITextField!
    
    var trip: Trip!
    
    let doneTripSegueIdentifier = "doneTripSegue"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.trip != nil {
            self.capacitySlider.value = Float(self.trip.capacity)
            self.fromField.text = self.trip.origin
            self.toField.text = self.trip.destination
            self.datePicker.date = self.trip.time
            self.priceField.text = "\(self.trip.price)"
        } else {
            self.capacitySlider.value = 0
        }
        updateView()
    }
    
    @IBAction func pressedDone(_ sender: Any) {
        let newTrip = Trip(capacity: Int(self.capacitySlider.value),
                           destination: self.toField.text!,
                           origin: self.fromField.text!,
                           price: Float(self.priceField.text!)!,
                           time: self.datePicker.date)
        //TODO: update to Firestore
    }
    
    @IBAction func changedSlider(_ sender: Any) {
        updateView()
    }
    
    func updateView() {
        capacityField.text = "\(Int(capacitySlider.value))"
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO: if segue is doneTripSegue then set the trip
    }

}

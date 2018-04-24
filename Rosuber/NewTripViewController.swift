//
//  NewTripViewController.swift
//  Rosuber
//
//  Created by Ryan Greenlee on 4/23/18.
//  Copyright © 2018 FengYizhi. All rights reserved.
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

    @IBAction func sliderChanged(_ sender: Any) {
        updateView()
    }
    
    func updateView() {
        capacityField.text = "\(Int(capacitySlider.value))"
    }
    
    @IBAction func pressedAdd(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

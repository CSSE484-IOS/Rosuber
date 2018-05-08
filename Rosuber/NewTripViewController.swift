//
//  NewTripViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/26.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import Firebase

class NewTripViewController: UIViewController, UITextFieldDelegate {
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
    
    var textFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        capacitySlider.value = 1
        fromField.delegate = self
        toField.delegate = self
        priceField.delegate = self
        updateView()
        textFields = [fromField, toField, priceField]
    }
    
    @IBAction func pressedDone(_ sender: Any) {
        for tf in textFields {
            unhighligh(textField: tf)
        }
        var isValid = true
        for tf in textFields {
            if tf.text!.isEmpty {
                isValid = false
                highlight(textField: tf)
            }
        }
        if isValid {
            addNewTrip()
        } else {
            let errorAlert = UIAlertController(title: "Required Field(s) Empty", message: "", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(errorAlert, animated: true)
        }
    }
    
    func addNewTrip() {
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
    
    func highlight(textField: UITextField) {
        textField.layer.borderWidth = 3.0
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    func unhighligh(textField: UITextField) {
        textField.layer.borderWidth = 0.0
        textField.layer.borderColor = UIColor.black.cgColor
    }
    
    func updateView() {
        if Int(capacitySlider.value) == 1 {
            capacityField.text = "1 passenger"
        } else {
            capacityField.text = "\(Int(capacitySlider.value)) passengers"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}

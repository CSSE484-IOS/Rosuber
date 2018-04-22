//
//  TripDetailViewController.swift
//  Rosuber
//
//  Created by Ryan Greenlee on 4/21/18.
//  Copyright © 2018 FengYizhi. All rights reserved.
//

import UIKit

class TripDetailViewController: UIViewController {

    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(showEditDialog))
    }
    
    @objc func showEditDialog() {
        let alertController = UIAlertController(title: "Edit trip",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Capacity"
            textField.text = "\(self.trip?.capacity)"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Destination"
            textField.text = self.trip?.destination
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Origin"
            textField.text = self.trip?.origin
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Price"
            textField.text = "\(self.trip?.price)"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Time"
            textField.text = "\(self.trip?.time)"
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: UIAlertActionStyle.cancel,
                                         handler: nil)
        let editTripAction = UIAlertAction(
            title: "Edit",
            style: UIAlertActionStyle.default) {
                (action) in
                let capacityTextField = alertController.textFields![0]
                let destinationTextField = alertController.textFields![1]
                let originTextField = alertController.textFields![2]
                let priceTextField = alertController.textFields![3]
                let timeTextField = alertController.textFields![4]
                self.trip?.capacity = Int(capacityTextField.text!)!
                self.trip?.destination = destinationTextField.text!
                self.trip?.origin = originTextField.text!
                self.trip?.price = Float(priceTextField.text!)!
                self.trip?.time = timeTextField.text!
                self.updateView()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(editTripAction)
        present(alertController, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        capacityLabel.text = "\(trip?.capacity)"
        destinationLabel.text = trip?.destination
        originLabel.text = trip?.origin
        priceLabel.text = "\(trip?.price)"
        timeLabel.text = trip?.time
    }

}

//
//  FindTripDetailViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/24.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import Firebase

class FindTripDetailViewController: UIViewController {
    let findDetailToFindSegueIdentifier = "findDetailToFindSegue"
    
    var trip: Trip!
    var tripRef: DocumentReference!
    var tripListener: ListenerRegistration!
    
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var passengerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tripRef = Firestore.firestore().collection("trips").document(trip.id!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tripListener = tripRef.addSnapshotListener({ (documentSnapshot, error) in
            if let error = error {
                print("Error getting the document: \(error.localizedDescription)")
                return
            }
            if !documentSnapshot!.exists {
                print("This document got deleted by someonee else!")
                return
            }
            self.trip = Trip(documentSnapshot: documentSnapshot!)
            self.updateView()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tripListener.remove()
    }
    
    func updateView() {
        originLabel.text = trip.origin
        destinationLabel.text = trip.destination
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        dateLabel.text = formatter.string(from: trip.time)
        
        formatter.dateFormat = "HH:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        timeLabel.text = formatter.string(from: trip.time)
        
        driverLabel.text = trip.driverKey
        passengerLabel.text = trip.passengersString
        priceLabel.text = "\(trip.price)"
        capacityLabel.text = "\(trip.capacity)"
    }
    
    
    @IBAction func pressedMenu(_ sender: Any) {
        let actionController = UIAlertController(title: "Find Trip Options", message: nil, preferredStyle: .actionSheet)
        
        actionController.addAction(UIAlertAction(title: "Contact Driver", style: .default, handler: { _ in
            print("pressed contact driver")
        }))
        actionController.addAction(UIAlertAction(title: "Contact Passenger(s)", style: .default, handler: { _ in
            print("pressed contact passenger(s)")
        }))
        
        actionController.addAction(UIAlertAction(title: "Join", style: .default, handler: { _ in
            print("pressed join")
        }))
        
        actionController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(actionController, animated: true)
    }
    
}

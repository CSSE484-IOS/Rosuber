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
    
    var driver: User?
    var passengers = [User]()
    
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
            self.parseDriver()
            self.parsePassengers()
            self.updateView()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tripListener.remove()
    }
    
    func parseDriver() {
        if trip.driverKey != "" {
            Firestore.firestore().collection("users").document(trip.driverKey).getDocument { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting driver \(self.trip.driverKey) from Firebase in Find Trip Detail page. Error: \(error.localizedDescription)")
                    return
                }
                if let document = documentSnapshot {
                    self.driver = User(documentSnapshot: document)
                    self.driverLabel.text = self.driver?.name
                }
            }
        }
    }
    
    func parsePassengers() {
        if !trip.passengersString.isEmpty {
            passengers.removeAll()
            let passengersArr = trip.passengersString.split(separator: ",")
            for p in passengersArr {
                Firestore.firestore().collection("users").document(String(p)).getDocument { (documentSnapshot, error) in
                    if let error = error {
                        print("Error getting passenger \(p) from Firebase in Find Trip Detail page. Error: \(error.localizedDescription)")
                        return
                    }
                    if let document = documentSnapshot {
                        self.passengers.append(User(documentSnapshot: document))
                        self.updatePassengersLabel()
                    } 
                }
            }
        }
    }
    
    func updatePassengersLabel() {
        var str = ""
        for i in 0..<self.passengers.count {
            str += self.passengers[i].name
            if i < self.passengers.count - 1 {
                str += "\n"
            }
        }
        self.passengerLabel.text = str
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
        
        if let driver = driver {
            driverLabel.text = driver.name
        } else {
            driverLabel.text = ""
        }
        
        if !passengers.isEmpty {
            updatePassengersLabel()
        }
        
        priceLabel.text = String(format: "%.2f", Float(trip.price))
        capacityLabel.text = "\(trip.capacity)"
    }
    
    
    @IBAction func pressedMenu(_ sender: Any) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let actionController = UIAlertController(title: "Find Trip Options", message: nil, preferredStyle: .actionSheet)
        
        if driver != nil && driver?.id != currentUser.uid {
            actionController.addAction(UIAlertAction(title: "Contact Driver", style: .default, handler: { _ in
                print("pressed contact driver")
            }))
        }
        
        if !passengers.isEmpty && !(passengers.count == 1 && passengers[0].id == currentUser.uid) {
            actionController.addAction(UIAlertAction(title: "Contact Passenger(s)", style: .default, handler: { _ in
                print("pressed contact passenger(s)")
            }))
        }
        
        actionController.addAction(UIAlertAction(title: "Join", style: .default, handler: { _ in
            print("pressed join")
        }))
        
        actionController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(actionController, animated: true)
    }
    
}

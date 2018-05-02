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
    
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var passengerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    
    var tripRef: DocumentReference?
    var tripListener: ListenerRegistration!
    var trip: Trip?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tripListener = tripRef?.addSnapshotListener({ (documentSnapshot, error) in
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
        originLabel.text = trip?.origin
        destinationLabel.text = trip?.destination
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        dateLabel.text = formatter.string(from: (trip?.time)!)
        
        formatter.dateFormat = "HH:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        timeLabel.text = formatter.string(from: (trip?.time)!)
        
        driverLabel.text = trip?.driverKey
        passengerLabel.text = trip?.passengerKeys
        priceLabel.text = "\(trip!.price)"
        capacityLabel.text = "\(trip!.capacity)"
    }

}

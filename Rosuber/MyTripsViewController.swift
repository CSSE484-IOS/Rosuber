//
//  MyTripsTableViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/24.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import Firebase

class MyTripsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let myTripCellIdentifier = "myTripCell"
    let myNoTripCellIdentifier = "myNoTripCell"
    
    var currentUserCollectionRef: CollectionReference!
    var tripsListener: ListenerRegistration!
    var trips = [Trip]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let currentUser = Auth.auth().currentUser else { return }
        currentUserCollectionRef = Firestore.firestore().collection(currentUser.uid)
        self.trips.removeAll()
        tripsListener = currentUserCollectionRef.order(by: "time", descending: true).addSnapshotListener({ (tripSnapshot, error) in
            guard let snapshot = tripSnapshot else {
                print("Error fetching trips. \(error!.localizedDescription)")
                return
            }
            snapshot.documentChanges.forEach({ (docChange) in
                if (docChange.type == .added) {
                    print("New trip: \(docChange.document.data())")
                    self.tripAdded(docChange.document)
                } else if (docChange.type == .modified) {
                    print("Modified trip: \(docChange.document.data())")
                    self.tripUpdated(docChange.document)
                } else if (docChange.type == .removed) {
                    print("Removed trip: \(docChange.document.data())")
                    self.tripRemoved(docChange.document)
                }
                self.trips.sort(by: { (t1, t2) -> Bool in
                    return t1.time > t2.time
                })
                self.tableView.reloadData()
            })
        })
    }
    
    func tripAdded(_ document: DocumentSnapshot) {
        let newTrip = Trip(documentSnapshot: document)
        trips.append(newTrip)
    }
    
    func tripUpdated(_ document: DocumentSnapshot) {
        let modifiedTrip = Trip(documentSnapshot: document)
        for trip in trips {
            if (trip.id == modifiedTrip.id) {
                trip.capacity = modifiedTrip.capacity
                trip.destination = modifiedTrip.destination
                trip.driverKey = modifiedTrip.driverKey
                trip.passengerKeys = modifiedTrip.passengerKeys
                trip.origin = modifiedTrip.origin
                trip.price = modifiedTrip.price
                trip.time = modifiedTrip.time
                break
            }
        }
    }
    
    func tripRemoved(_ document: DocumentSnapshot) {
        for i in 0 ..< trips.count {
            if trips[i].id == document.documentID {
                trips.remove(at: i)
                break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tripsListener.remove()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if trips.count == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: myNoTripCellIdentifier, for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: myTripCellIdentifier, for: indexPath)
            cell.textLabel?.text = "\(trips[indexPath.row].origin) - \(trips[indexPath.row].destination)"
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy HH:mma"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            cell.detailTextLabel?.text = formatter.string(from: trips[indexPath.row].time)
        }
        
        return cell
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

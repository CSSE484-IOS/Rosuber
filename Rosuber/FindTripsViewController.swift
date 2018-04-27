//
//  FindTripsTableViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/24.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FindTripsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tripsRef: DatabaseReference!
//    var tripsListener: ListenerRegistration!
    
    let findTripCellIdentifier = "findTripCell"
    let findNoTripCellIdentifier = "findNoTripCell"
    var trips = [Trip]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tripsRef = Database.database().reference().child("trips")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.trips.removeAll()
        tripsRef.queryOrdered(byChild: "time")
        tripsRef.observe(.childAdded, with: { (dataSnapshot) in
            print("New trip: \(dataSnapshot.value)")
            self.tripAdded(dataSnapshot)
            self.trips.sort(by: { (t1, t2) -> Bool in
                return t1.time > t2.time
            })
            self.tableView.reloadData()
        }) { (error) in
            print("Error fetching trips. error: \(error.localizedDescription)")
            return
        }
        tripsRef.observe(.childChanged, with: { (dataSnapshot) in
            print("Modified trip: \(dataSnapshot.value)")
            self.tripUpdated(dataSnapshot)
            self.trips.sort(by: { (t1, t2) -> Bool in
                return t1.time > t2.time
            })
            self.tableView.reloadData()
        }) { (error) in
                print("Error fetching trips. error: \(error.localizedDescription)")
                return
        }
        tripsRef.observe(.childRemoved, with: { (dataSnapshot) in
            print("Removed trip: \(dataSnapshot.value)")
            self.tripRemoved(dataSnapshot)
            self.trips.sort(by: { (t1, t2) -> Bool in
                return t1.time > t2.time
            })
            self.tableView.reloadData()
            }) { (error) in
                    print("Error fetching trips. error: \(error.localizedDescription)")
                    return
            }
    }
    
    func tripAdded(_ data: DataSnapshot) {
        let newTrip = Trip(dataSnapshot: data)
        trips.append(newTrip)
    }
    
    func tripUpdated(_ data: DataSnapshot) {
        let modifiedTrip = Trip(dataSnapshot: data)
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
    
    func tripRemoved(_ data: DataSnapshot) {
        for i in 0 ..< trips.count {
            if trips[i].id == data.key {
                trips.remove(at: i)
                break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        tripsListener.remove()
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(trips.count, 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if trips.count == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: findNoTripCellIdentifier, for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: findTripCellIdentifier, for: indexPath)
            cell.textLabel?.text = "\(trips[indexPath.row].origin) - \(trips[indexPath.row].destination)"
            cell.detailTextLabel?.text = "\(trips[indexPath.row])"
        }
        
        return cell
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  TripTableViewController.swift
//  Rosuber
//
//  Created by Ryan Greenlee on 4/21/18.
//  Copyright © 2018 FengYizhi. All rights reserved.
//

import UIKit

class TripsTableViewController: UITableViewController {
    
    let tripCellIdentifier = "TripCell"
    let noTripCellIdentifier = "NoTripCell"
    let showTripDetailSegueIdentifier = "ShowTripDetailSegue"
    let newTripSegueIdentifier = "NewTripSegue"
    var trips = [Trip]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
//                                                            target: self,
//                                                            action: #selector(showAddDialog))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
//    @objc func showAddDialog() {
//        let alertController = UIAlertController(title: "Create a new trip",
//                                                message: "",
//                                                preferredStyle: .alert)
//        alertController.addTextField { (textField) in
//            textField.placeholder = "Capacity"
//        }
//        alertController.addTextField { (textField) in
//            textField.placeholder = "Destination"
//        }
//        alertController.addTextField { (textField) in
//            textField.placeholder = "Origin"
//        }
//        alertController.addTextField { (textField) in
//            textField.placeholder = "Price"
//        }
//        alertController.addTextField { (textField) in
//            textField.placeholder = "Time"
//        }
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: UIAlertActionStyle.cancel,
//                                         handler: nil)
//        let createTripAction = UIAlertAction(title: "Create Trip",
//                                             style: UIAlertActionStyle.default) {
//                                                (action) in
//                                                let capacityTextField = alertController.textFields![0]
//                                                let destinationTextField = alertController.textFields![1]
//                                                let originTextField = alertController.textFields![2]
//                                                let priceTextField = alertController.textFields![3]
//                                                let timeTextField = alertController.textFields![4]
//                                                let trip = Trip(capacity: Int(capacityTextField.text!)!, destination: destinationTextField.text!, origin: originTextField.text!, price: Float(priceTextField.text!)!, time: timeTextField.text!)
//                                                self.trips.insert(trip, at: 0)
//                                                if self.trips.count == 1 {
//                                                    self.tableView.reloadData()
//                                                } else {
//                                                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.top)
//                                                }
//        }
//        alertController.addAction(cancelAction)
//        alertController.addAction(createTripAction)
//        present(alertController, animated: true, completion: nil)
//    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        if trips.count == 0 {
            print("Don't allow editing mode at this time")
            super.setEditing(false, animated: animated)
        } else {
            super.setEditing(editing, animated: animated)
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(trips.count, 1)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if trips.count == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: noTripCellIdentifier, for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: tripCellIdentifier, for: indexPath)
            cell.textLabel?.text = "\(trips[indexPath.row].origin) to \(trips[indexPath.row].destination)"
            cell.detailTextLabel?.text = trips[indexPath.row].time.description
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return trips.count > 0
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            trips.remove(at: indexPath.row)
            if trips.count == 0 {
                tableView.reloadData()
                self.setEditing(false, animated: true)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == showTripDetailSegueIdentifier {
            // Goal: Pass the selected trip to the detail view controller.
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                (segue.destination as! TripDetailViewController).trip = trips[indexPath.row]
            }
        }
    }

}

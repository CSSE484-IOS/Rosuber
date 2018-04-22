//
//  UsersTableViewController.swift
//  Rosuber
//
//  Created by Ryan Greenlee on 4/22/18.
//  Copyright © 2018 FengYizhi. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    let userCellIdentifier = "UserCell"
    let noUserCellIdentifier = "NoUserCell"
    let showUserDetailSegueIdentifier = "ShowUserDetailSegue"
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showAddDialog))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func showAddDialog() {
        let alertController = UIAlertController(title: "Create a new user",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Phone Number"
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: UIAlertActionStyle.cancel,
                                         handler: nil)
        let createUserAction = UIAlertAction(title: "Create User",
                                             style: UIAlertActionStyle.default) {
                                                (action) in
                                                let emailTextField = alertController.textFields![0]
                                                let nameTextField = alertController.textFields![1]
                                                let phoneNumberTextField = alertController.textFields![2]
                                                let user = User(email: emailTextField.text!, name: nameTextField.text!, phoneNumber: phoneNumberTextField.text!)
                                                self.users.insert(user, at: 0)
                                                if self.users.count == 1 {
                                                    self.tableView.reloadData()
                                                } else {
                                                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.top)
                                                }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createUserAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if users.count == 0 {
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
        return max(users.count, 1)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if users.count == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: noUserCellIdentifier, for: indexPath)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath)
            cell.textLabel?.text = users[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return users.count > 0
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            users.remove(at: indexPath.row)
            if users.count == 0 {
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
        if segue.identifier == showUserDetailSegueIdentifier {
            // Goal: Pass the selected user to the detail view contoller.
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                (segue.destination as! UserDetailViewController).user = users[indexPath.row]
            }
        }
    }

}

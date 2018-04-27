//
//  UserDetailViewController.swift
//  Rosuber
//
//  Created by Ryan Greenlee on 4/22/18.
//  Copyright © 2018 FengYizhi. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var user: User?
    
    var editProfileSegueIdentifier = "EditProfileSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
//                                                            target: self,
//                                                            action: #selector(showEditDialog))
    }
    
    @objc func showEditDialog() {
        let alertController = UIAlertController(title: "Edit user",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
            textField.text = self.user?.email
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.text = self.user?.name
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Phone Number"
            textField.text = self.user?.phoneNumber
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: UIAlertActionStyle.cancel,
                                         handler: nil)
        let editUserAction = UIAlertAction(
            title: "Edit",
            style: UIAlertActionStyle.default) {
                (action) in
                let emailTextField = alertController.textFields![0]
                let nameTextField = alertController.textFields![1]
                let phoneNumberTextField = alertController.textFields![2]
                self.user?.email = emailTextField.text!
                self.user?.name = nameTextField.text!
                self.user?.phoneNumber = phoneNumberTextField.text!
                self.updateView()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(editUserAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        emailLabel.text = user?.email
        nameLabel.text = user?.name
        phoneNumberLabel.text = user?.phoneNumber
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == editProfileSegueIdentifier {
            (segue.destination as! UserEditViewController).user = self.user
        }
     }
    

}

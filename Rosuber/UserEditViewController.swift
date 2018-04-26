//
//  UserEditViewController.swift
//  Rosuber
//
//  Created by Ryan Greenlee on 4/25/18.
//  Copyright © 2018 FengYizhi. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.user != nil {
            self.emailField.text = self.user?.email
            self.nameField.text = self.user?.name
            self.phoneNumberField.text = self.user?.phoneNumber
        }
    }

    @IBAction func pressedSave(_ sender: Any) {
        self.user?.email = self.emailField.text!
        self.user?.name = self.nameField.text!
        self.user?.phoneNumber = self.phoneNumberField.text!
        self.navigationController?.popViewController(animated: true)
        let userDetailViewController = self.navigationController?.topViewController as! UserDetailViewController
        userDetailViewController.updateView()
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }

}

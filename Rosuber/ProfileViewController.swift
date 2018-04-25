//
//  ProfileViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/22.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var menuBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var blackView: UIView!
    
    var showMenu = true
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    @IBAction func pressedEdit(_ sender: Any) {
        if showMenu {
            blackView.alpha = 1
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            menuBottomConstraint.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            handleDismiss()
        }
        showMenu = !showMenu
    }
    
    @objc func handleDismiss() {
        blackView.alpha = 0
        menuBottomConstraint.constant = 100
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func pressedUpdatePhone(_ sender: Any) {
        let alertController = UIAlertController(title: "Update My Phone Number", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "My Phone Number"
            textField.keyboardType = .numberPad
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let defaultAction = UIAlertAction(title: "Update", style: .default) { (action) -> Void in
            let phoneTextField = alertController.textFields![0]
            if phoneTextField.text!.count == 10 {
                let start = phoneTextField.text!.index(phoneTextField.text!.startIndex, offsetBy: 3)
                let end = phoneTextField.text!.index(phoneTextField.text!.endIndex, offsetBy: -4)
                let range = start..<end
                self.phoneLabel.text = "\(phoneTextField.text!.prefix(3))-\(phoneTextField.text![range])-\(phoneTextField.text!.suffix(4))"
                self.handleDismiss()
            } else {
                let errorAlert = UIAlertController(title: "Error", message: "Please enter a 10-digit number!", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true)
                }))
                self.present(errorAlert, animated: true)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
    
    
}

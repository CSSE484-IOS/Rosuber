//
//  TripDetailViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/24.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import MessageUI

class MyTripDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    let myDetailToMySegueIdentifier = "myDetailToMySegue"
    
    var trip: Trip?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pressedMenu(_ sender: Any) {
        let actionController = UIAlertController(title: "My Trip Options", message: nil, preferredStyle: .actionSheet)
        
        actionController.addAction(UIAlertAction(title: "Contact Driver", style: .default, handler: { _ in
            self.sendMessage()
        }))
        actionController.addAction(UIAlertAction(title: "Contact Passenger(s)", style: .default, handler: { _ in
            self.sendEmail()
        }))
        
        actionController.addAction(UIAlertAction(title: "Leave", style: .destructive, handler: { _ in
            let alertController = UIAlertController(title: "Are you sure you want to leave this trip?", message: "", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Leave", style: .destructive, handler: { _ in
                self.leaveTrip()
            }))
            self.present(alertController, animated: true)
        }))
        
        actionController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(actionController, animated: true)
    }
    
    func leaveTrip() {
        print("leaving trip")
    }
    
    func sendMessage() {
        if MFMessageComposeViewController.canSendText() {
            let controller = MFMessageComposeViewController()
            controller.messageComposeDelegate = self
            controller.body = "sending message to driver"
            controller.recipients = ["5555555555"]
            controller.messageComposeDelegate = self
            present(controller, animated: true, completion: nil)
        } else {
            let errorAlert = UIAlertController(title: "Error", message: "No Message Service available!", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(errorAlert, animated: true)
        }
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let controller = MFMailComposeViewController()
            controller.mailComposeDelegate = self
            controller.setToRecipients(["fengy2@rose-hulman.edu"])
            controller.setSubject("Hello!")
            controller.setMessageBody("Hello this is my mail body!", isHTML: false)
            present(controller, animated: true, completion: nil)
        } else {
            let errorAlert = UIAlertController(title: "Error", message: "No Mail Service available!", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(errorAlert, animated: true)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//
//  HomeViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/17.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import Firebase
import Rosefire
import MaterialComponents.MaterialSnackbar

class HomeViewController: UIViewController {
    let ROSEFIRE_REGISTRY_TOKEN = "4cecdaba-e05f-435d-bbfe-8b111f2447f4"
    
    let homeToProfileSegueIdentifier = "homeToProfileSegue"
    let homeToMySegueIdentifier = "homeToMySegue"
    let homeToFindSegueIdentifier = "homeToFindSegue"
    let homeToAboutSegueIdentifier = "homeToAboutSegue"
    
    var showMenu = true
    
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var loginLogoutButton: UIBarButtonItem!
    @IBOutlet weak var spinnerStackView: UIStackView!
    @IBOutlet weak var spinnerLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var myTripsButton: UIButton!
    @IBOutlet weak var findTripsButton: UIButton!
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var helloDetailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        spinnerStackView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViewBasedOnAuth(Auth.auth().currentUser != nil)
    }
    
    func updateViewBasedOnAuth(_ signedIn: Bool) {
        loginLogoutButton.image = signedIn ? #imageLiteral(resourceName: "logout") : #imageLiteral(resourceName: "login")
        loginLogoutButton.tintColor = signedIn ? UIColor.red : UIColor.black
        profileButton.isEnabled = signedIn
        myTripsButton.isEnabled = signedIn
        findTripsButton.isEnabled = signedIn
        
        updateGreetingLabels(signedIn)
    }
    
    func updateGreetingLabels(_ signedIn: Bool) {
        if signedIn {
            if let currentUser = Auth.auth().currentUser {
                let userRef = Firestore.firestore().collection("users").document(currentUser.uid)
                userRef.getDocument { (documentSnapshot, error) in
                    if let error = error {
                        print("Error fetching user document.  \(error.localizedDescription)")
                        return
                    }
                    if let document = documentSnapshot {
                        if document.exists {
                            let user = User(documentSnapshot: document)
                            self.helloLabel.text = "Hi, \(user.name.split(separator: " ")[0])!"
                            self.helloDetailLabel.text = "You're an Rosuber user"
                            let formatter = DateFormatter()
                            formatter.dateFormat = "MMM dd, yyyy"
                            let date = formatter.string(from: user.created)
                            self.dateLabel.text = "since \(date)."
                        }
                    }
                }
            }
        } else {
            helloLabel.text = "Dear Rose Family,"
            helloDetailLabel.text = "Please login to explore Rosuber!"
            dateLabel.text = ""
        }
    }
    
    @IBAction func pressedMenu(_ sender: Any) {
        if showMenu {
            blackView.alpha = 1
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            menuLeadingConstraint.constant = 0
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
        menuLeadingConstraint.constant = -150
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func pressedLoginLogout(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            blackView.alpha = 1
            spinnerStackView.isHidden = false
            spinnerLabel.text = "Signing in Rosefire..."
            loginViaRosefire()
        } else {
            let ac = UIAlertController(title: "Are you sure you want to logout?", message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (action) in
                self.appDelegate.handleLogout()
            }))
            present(ac, animated: true)
        }
    }
    
    func loginViaRosefire() {
        Rosefire.sharedDelegate().uiDelegate = self
        Rosefire.sharedDelegate().signIn(registryToken: ROSEFIRE_REGISTRY_TOKEN) {
            (error, result) in
            if let error = error {
                print("Error communicating with Rosefire! \(error.localizedDescription)")
                return
            }
            print("You are now signed in with Rosefire! username: \(result!.username)")
            Auth.auth().signIn(withCustomToken: result!.token, completion: { (user, error) in
                if let error = error {
                    print("Error during log in: \(error.localizedDescription)")
                    let ac = UIAlertController(title: "Login failed", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(ac, animated: true)
                } else {
                    self.appDelegate.handleLogin(result: result!)
                }
            })
        }
    }
}

extension UIApplicationDelegate {
    func showSignedOutSnackbar() {
        let message = MDCSnackbarMessage()
        message.text = "You've signed out!"
        MDCSnackbarManager.show(message)
    }
}


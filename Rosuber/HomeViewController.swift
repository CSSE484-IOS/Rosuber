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

class HomeViewController: UIViewController {
    let ROSEFIRE_REGISTRY_TOKEN = "4cecdaba-e05f-435d-bbfe-8b111f2447f4"
    
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var loginLogoutButton: UIBarButtonItem!
    
    var showMenu = true
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var myTripsButton: UIButton!
    @IBOutlet weak var findTripsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        updateViewBasedOnAuth(Auth.auth().currentUser != nil)
    }
    
    func updateViewBasedOnAuth(_ signedIn: Bool) {
        loginLogoutButton.image = signedIn ? #imageLiteral(resourceName: "logout") : #imageLiteral(resourceName: "login")
        profileButton.isEnabled = signedIn
        myTripsButton.isEnabled = signedIn
        findTripsButton.isEnabled = signedIn
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
            loginViaRosefire()
            updateViewBasedOnAuth(true)
        } else {
            appDelegate.handleLogout()
            updateViewBasedOnAuth(false)
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


//
//  ProfileViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/22.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var menuBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var showMenu = true
    var imagePicker = UIImagePickerController()
    var profileImage: UIImage?
    
    var user: User!
    var userRef: DocumentReference!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
//        if profileImage != nil {
//            imageView.contentMode = .scaleToFill
//            imageView.image = profileImage
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = appDelegate.user
        userRef = Firestore.firestore().collection("users").document(user.id)
        updateView()
    }
    
    func updateView() {
        nameLabel.text = user.name
        usernameLabel.text = user.id
        emailLabel.text = user.email
        
        if user.phoneNumber.count == 10 {
            let start = user.phoneNumber.index(user.phoneNumber.startIndex, offsetBy: 3)
            let end = user.phoneNumber.index(user.phoneNumber.endIndex, offsetBy: -4)
            let range = start..<end
            phoneLabel.text = "\(user.phoneNumber.prefix(3))-\(user.phoneNumber[range])-\(user.phoneNumber.suffix(4))"
        }
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
                self.user.phoneNumber = phoneTextField.text!
                self.updateView()
                self.userRef.setData(self.user.data)
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
    
    @IBAction func pressedUploadImage(_ sender: Any) {
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alertController.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alertController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker, animated: true)
        } else {
            let errorAlert = UIAlertController(title: "Error", message: "No camera available!", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                alert -> Void in
                self.pressedUploadImage(self)
            }))
            present(errorAlert, animated: true)
        }
    }
    
    func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            imagePicker.modalPresentationStyle = .popover
            present(imagePicker, animated: true)
        } else {
            let errorAlert = UIAlertController(title: "Error", message: "No camera available!", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                alert -> Void in
                self.pressedUploadImage(self)
            }))
            present(errorAlert, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage = pickedImage
            imageView.contentMode = .scaleToFill
            imageView.image = pickedImage
        }
        picker.dismiss(animated: true)
        handleDismiss()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        pressedUploadImage(self)
    }
}

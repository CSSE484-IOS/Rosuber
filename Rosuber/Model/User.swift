//
//  User.swift
//  Rosuber
//
//  Created by Ryan Greenlee on 4/21/18.
//  Copyright © 2018 FengYizhi. All rights reserved.
//
import UIKit

class User: NSObject {
    var id: String?
    var email: String
    var name: String
    var phoneNumber: String
    
    let emailKey = "email"
    let nameKey = "name"
    let phoneNumberKey = "phoneNumber"
    
    init(email: String, name: String, phoneNumber: String) {
        self.email = email
        self.name = name
        self.phoneNumber = phoneNumber
    }
    
    var data: [String: Any] {
        return [emailKey: self.email,
                nameKey: self.name,
                phoneNumberKey: self.phoneNumber]
    }
}

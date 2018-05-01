//
//  Trip.swift
//  Rosuber
//
//  Created by Ryan Greenlee on 4/20/18.
//  Copyright © 2018 FengYizhi. All rights reserved.
//
import UIKit
import Firebase

class Trip: NSObject {
    var id: String?
    var capacity: Int
    var destination: String
    var driverKey: String
    var passengerKeys: String
    var origin: String
    var price: Float
    var time: Date!
    var created: Date?
    
    let capacityKey = "capacity"
    let destinationKey = "destination"
    let driverKeyKey = "driverKey"
    let passengerKeysKey = "passengerKeys"
    let originKey = "origin"
    let priceKey = "price"
    let timeKey = "time"
    let createdKey = "created"
    
    init(capacity: Int, destination: String, origin: String, price: Float, time: Date) {
        self.capacity = capacity
        self.destination = destination
        self.driverKey = ""
        self.passengerKeys = ""
        self.origin = origin
        self.price = price
        self.time = time
        self.created = Date()
    }
    
    init(documentSnapshot: DocumentSnapshot) {
        self.id = documentSnapshot.documentID
        let data = documentSnapshot.data()!
        self.destination = data[destinationKey] as! String
        self.driverKey = data[driverKeyKey] as! String
        self.passengerKeys = data[passengerKeysKey] as! String
        self.capacity = documentSnapshot.get(capacityKey) as? Int ?? 0
        self.origin = data[originKey] as! String
        self.price = data[priceKey] as! Float
        if data[timeKey] != nil {
            self.time = data[timeKey] as! Date
        }
        if data[createdKey] != nil {
            self.created = data[createdKey] as! Date
        }
    }
    
    init(documentSnapshot: DocumentSnapshot) {
        self.id = documentSnapshot.documentID
        let data = documentSnapshot.data()!
        self.capacity = data[capacityKey] as! Int
        self.destination = data[destinationKey] as! String
        self.driverKey = data[driverKeyKey] as! String
        self.passengerKeys = data[passengerKeysKey] as! String
        self.origin = data[originKey] as! String
        self.price = data[priceKey] as! Float
        self.time = data[timeKey] as! Date
    }
    
    init(dataSnapshot: DataSnapshot) {
        self.id = dataSnapshot.key
        let data = dataSnapshot.value as? [String : AnyObject] ?? [:]
        self.capacity = data[capacityKey] as! Int
        self.destination = data[destinationKey] as! String
        self.driverKey = data[driverKeyKey] as! String
        self.passengerKeys = data[passengerKeysKey] as! String
        self.origin = data[originKey] as! String
        self.price = data[priceKey] as! Float
        self.time = data[timeKey] as! Date
    }
    
    var data: [String: Any] {
        return [capacityKey: self.capacity,
                destinationKey: self.destination,
                driverKeyKey: self.driverKey,
                passengerKeysKey: self.passengerKeys,
                originKey: self.origin,
                priceKey: self.price,
                timeKey: self.time,
                createdKey: self.created]
    }
    
}

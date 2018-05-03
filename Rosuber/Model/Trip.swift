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
    var time: Date
    var created: Date
    var passengerMap: [String: Bool]?
    
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
        self.time = data[timeKey] as! Date
        self.created = data[createdKey] as! Date
        if data["passengerMap"] != nil {
            self.passengerMap = data["passengerMap"] as! [String: Bool]
            for (key,_) in self.passengerMap! {
                print("\(key)")
            }
        }
    }
    
    var data: [String: Any] {
        //TODO: include driverKey and passengerKeys
        return [capacityKey: self.capacity,
                destinationKey: self.destination,
                originKey: self.origin,
                priceKey: self.price,
                timeKey: self.time,
                createdKey: self.created]
    }
    
//    func contains(passenger: String) -> Bool {
//        for i in 0..<passengers.count {
//            if passengers[i] == passenger {
//                return true
//            }
//        }
//        return false
//    }
//
//    var passengers: [String.SubSequence] {
//        return self.passengerKeys.split(separator: ",")
//    }
}

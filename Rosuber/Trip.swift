//
//  Trip.swift
//  Rosuber
//
//  Created by Ryan Greenlee on 4/20/18.
//  Copyright © 2018 FengYizhi. All rights reserved.
//

import UIKit

class Trip: NSObject {
    var id: String?
    var capacity: Int
    var destination: String
//    var driverKey: String
    var origin: String
    var price: Float
    var time: String
    
    let capacityKey = "capacity"
    let destinationKey = "destination"
//    let driverKeyKey = "driverKey"
    let originKey = "origin"
    let priceKey = "price"
    let timeKey = "time"
    
    init(capacity: Int, destination: String, origin: String, price: Float, time: String) {
        self.capacity = capacity
        self.destination = destination
        self.origin = origin
        self.price = price
        self.time = time
    }
    
    var data: [String: Any] {
        return [capacityKey: self.capacity,
                destinationKey: self.destination,
                originKey: self.origin,
                priceKey: self.price,
                timeKey: self.time]
    }

}

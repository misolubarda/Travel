//
//  TrainTrip.swift
//  Travel
//
//  Created by Miso Lubarda on 20/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

@objc final class TrainTrip: NSObject, Trip {
    var vehicleID: String = ""
    var providerLogo: NSURL = NSURL()
    var priceInEuro: Float = 0
    var departureTime: NSDate = NSDate()
    var arrivalTime: NSDate = NSDate()
    var stops: Int = 0
    
    override init() {}
}

//
//  FlightTrip.swift
//  Travel
//
//  Created by Miso Lubarda on 20/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

@objc final class FlightTrip: NSObject, Trip {
    var vehicleID: Int = 0
    var providerLogo: NSURL = NSURL()
    var priceInEuro: Float = 0
    var departureTime: NSDate = NSDate()
    var arrivalTime: NSDate = NSDate()
    var stops: Int = 0
    
    override init() {}
    
    func duration() -> NSDate? {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: self.departureTime, toDate: self.arrivalTime, options: [])
        let date = calendar.dateFromComponents(components)
        return date
    }
}

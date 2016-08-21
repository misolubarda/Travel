//
//  Transportable.swift
//  Travel
//
//  Created by Miso Lubarda on 20/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

protocol Trip: class {
    
    var vehicleID: Int {get set}
    var providerLogo: NSURL {get set}
    var priceInEuro: Float {get set}
    var departureTime: NSDate {get set}
    var arrivalTime: NSDate {get set}
    var stops: Int {get set}
    
    init()
}

extension Trip {
    init(JSONDict: [String: AnyObject]) throws {
        guard let id = JSONDict["id"] as? Int else {
            throw TripError.ParsingID
        }
        
        guard var logo = JSONDict["provider_logo"] as? String else {
            throw TripError.ParsingProviderLogo
        }
        
        logo = logo.stringByReplacingOccurrencesOfString("{size}", withString: "63")
        
        guard let logoURL = NSURL(string: logo) else {
            throw TripError.ParsingProviderLogo
        }
        
        guard let price = JSONDict["price_in_euros"] as? Float else {
            throw TripError.ParsingPrice
        }
        
        guard let departureString = JSONDict["departure_time"] as? String else {
            throw TripError.ParsingDeparture
        }
        
        guard let departure = Helper.dateFormatter().dateFromString(departureString) else {
            throw TripError.ParsingDeparture
        }
        
        guard let arrivalString = JSONDict["arrival_time"] as? String else {
            throw TripError.ParsingArrival
        }
        
        guard let arrival = Helper.dateFormatter().dateFromString(arrivalString) else {
            throw TripError.ParsingArrival
        }
        
        guard let stopsNum = JSONDict["number_of_stops"] as? Int else {
            throw TripError.ParsingNumberOfStops
        }
        
        self.init()
        
        self.vehicleID = id
        self.providerLogo = logoURL
        self.priceInEuro = price
        self.departureTime = departure
        self.arrivalTime = arrival
        self.stops = stopsNum
    }
}

enum TripError: ErrorType {
    case ParsingID, ParsingProviderLogo, ParsingPrice, ParsingDeparture, ParsingArrival, ParsingNumberOfStops
}

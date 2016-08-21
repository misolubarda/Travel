//
//  Transportable.swift
//  Travel
//
//  Created by Miso Lubarda on 20/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

protocol Trip: NSObjectProtocol {
    
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
        guard let id = JSONDict["id"]?.integerValue else {
            throw TripError.ParsingID
        }
        
        guard var logo = JSONDict["provider_logo"] as? String else {
            throw TripError.ParsingProviderLogo
        }
        
        logo = logo.stringByReplacingOccurrencesOfString("{size}", withString: "63")
        
        guard let logoURL = NSURL(string: logo) else {
            throw TripError.ParsingProviderLogo
        }
        
        guard let price = JSONDict["price_in_euros"]?.floatValue else {
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
        
        guard let stopsNum = JSONDict["number_of_stops"]?.integerValue else {
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
    
    
    func exportToJSONDict() -> [String: AnyObject] {
        
        var jsonDict = [String: AnyObject]()
        jsonDict["id"] = self.vehicleID
        jsonDict["provider_logo"] = self.providerLogo.absoluteString
        jsonDict["price_in_euros"] = self.priceInEuro
        jsonDict["departure_time"] = Helper.dateFormatter().stringFromDate(self.departureTime)
        jsonDict["arrival_time"] = Helper.dateFormatter().stringFromDate(self.arrivalTime)
        jsonDict["number_of_stops"] = self.stops
        
        return jsonDict
    }
}

enum TripError: ErrorType {
    case ParsingID, ParsingProviderLogo, ParsingPrice, ParsingDeparture, ParsingArrival, ParsingNumberOfStops
}

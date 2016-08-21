//
//  LocalStorage.swift
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

struct LocalStorage {
    
    static func fetchTrips<T: Trip>() throws -> [T] {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultsKey = try self.defaultsKeyForTripType(T)
        guard let tripArray = defaults.objectForKey(defaultsKey) as? [[String: AnyObject]] else {
            return []
        }
        
        let trips: [T] = try tripArray.map {
            try T(JSONDict: $0)
        }
        
        return trips
    }
    
    static func saveTrips<T: Trip>(trips: [T]) throws {
        
        let tripArray: [[String: AnyObject]] = trips.map {
            $0.exportToJSONDict()
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultsKey = try self.defaultsKeyForTripType(T)
        defaults.setObject(tripArray, forKey: defaultsKey)
    }
    
    static func defaultsKeyForTripType<T: Trip>(type: T.Type) throws -> String {
        var defaultsKey: String?
        if T.self == FlightTrip.self {
            defaultsKey = "flightsKey"
        } else if T.self == BusTrip.self {
            defaultsKey = "busesKey"
        } else if T.self == TrainTrip.self {
            defaultsKey = "trainsKey"
        }
        
        guard let recognizedDefaultsKey = defaultsKey else {
            throw LocalStorageError.DefaultsKeyUnknown
        }
        
        return recognizedDefaultsKey
    }
}

extension LocalStorage {
    enum LocalStorageError: ErrorType {
        case DefaultsKeyUnknown
    }
}
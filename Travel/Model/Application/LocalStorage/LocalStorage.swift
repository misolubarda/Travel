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
        guard let tripArray = defaults.objectForKey("testTripEncodingDecoding") as? [[String: AnyObject]] else {
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
        defaults.setObject(tripArray, forKey: "testTripEncodingDecoding")
    }
}

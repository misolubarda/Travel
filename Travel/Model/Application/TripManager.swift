//
//  TripManager.swift
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

enum TripManagerTripType {
    case Flight, Bus, Train
}

@objc class TripManager: NSObject {
    
    static let mainInstance = TripManager()
    static let baseURL = NSURL(string: "https://api.myjson.com/bins/")!
        
    @objc class func fetchBusTripsWithCompletion(completion: (response: [BusTrip]?) -> Void) {
        
        // Fetch trips from local storage first.
        let busTrips: [BusTrip]? = try? LocalStorage.fetchTrips()
        
        if let busTrips = busTrips {
            completion(response: busTrips);
        }

        // Fetch trips from server.
        let busRequest = BusesAPIRequest(baseURL: baseURL, responseQueue: dispatch_get_main_queue())
        
        busRequest.prepareWithCompletion { (response: () throws -> [BusTrip]) in
            
            if let response = try? response() {
                // No server error, return response
                _ = try? LocalStorage.saveTrips(response)
                completion(response: response)
                return
            } else {
                // Server error. Try to fetch from local database.
                completion(response: busTrips)
            }
        }
        busRequest.execute()
    }
    
    @objc class func fetchFlightTripsWithCompletion(completion: (response: [FlightTrip]?) -> Void) {
        let flightRequest = FlightsAPIRequest(baseURL: baseURL, responseQueue: dispatch_get_main_queue())
        
        flightRequest.prepareWithCompletion { (response: () throws -> [FlightTrip]) in
            
            if let response = try? response() {
                // No server error, return response
                completion(response: response)
                return
            } else {
                // Server error. Try to fetch from local database.
                let flightTrips: [FlightTrip]? = try? LocalStorage.fetchTrips()
                completion(response: flightTrips)
            }
        }
        flightRequest.execute()
    }
    
    @objc class func fetchTrainTripsWithCompletion(completion: (response: [TrainTrip]?) -> Void) {
        let trainRequest = TrainsAPIRequest(baseURL: baseURL, responseQueue: dispatch_get_main_queue())
        
        trainRequest.prepareWithCompletion { (response: () throws -> [TrainTrip]) in
            
            if let response = try? response() {
                // No server error, return response
                completion(response: response)
                return
            } else {
                // Server error. Try to fetch from local database.
                let TrainTrips: [TrainTrip]? = try? LocalStorage.fetchTrips()
                completion(response: TrainTrips)
            }
        }
        trainRequest.execute()
    }
}

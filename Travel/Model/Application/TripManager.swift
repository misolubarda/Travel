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
    
    /// Tracking last request to prevent multiple async responses.
    var lastRequest: NSDate?
        
    @objc class func fetchBusTripsWithCompletion(completion: (response: [BusTrip]?) -> Void) {
        
        let requestTimestamp = NSDate()
        self.mainInstance.lastRequest = requestTimestamp
        
        // Fetch trips from local storage first.
        let busTrips: [BusTrip]? = try? LocalStorage.fetchTrips()
        
        if let busTrips = busTrips {
            completion(response: busTrips);
        }

        // Fetch trips from server.
        let busRequest = BusesAPIRequest(baseURL: baseURL, responseQueue: dispatch_get_main_queue())
        
        busRequest.prepareWithCompletion { (response: () throws -> [BusTrip]) in
            
            if self.mainInstance.lastRequest != requestTimestamp {
                return;
            }
            
            if let response = try? response() {
                // No server error, save to local storage and return response
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
        
        let requestTimestamp = NSDate()
        self.mainInstance.lastRequest = requestTimestamp

        // Fetch trips from local storage first.
        let flightTrips: [FlightTrip]? = try? LocalStorage.fetchTrips()
        
        if let flightTrips = flightTrips {
            completion(response: flightTrips);
        }
        
        // Fetch trips from server.
        let flightRequest = FlightsAPIRequest(baseURL: baseURL, responseQueue: dispatch_get_main_queue())
        
        flightRequest.prepareWithCompletion { (response: () throws -> [FlightTrip]) in
            
            if self.mainInstance.lastRequest != requestTimestamp {
                return;
            }

            if let response = try? response() {
                // No server error, save to local storage and return response
                _ = try? LocalStorage.saveTrips(response)
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
        
        let requestTimestamp = NSDate()
        self.mainInstance.lastRequest = requestTimestamp

        // Fetch trips from local storage first.
        let trainTrips: [TrainTrip]? = try? LocalStorage.fetchTrips()
        
        if let trainTrips = trainTrips {
            completion(response: trainTrips);
        }
        
        // Fetch trips from server.
        let trainRequest = TrainsAPIRequest(baseURL: baseURL, responseQueue: dispatch_get_main_queue())
        
        trainRequest.prepareWithCompletion { (response: () throws -> [TrainTrip]) in
            
            if self.mainInstance.lastRequest != requestTimestamp {
                return;
            }

            if let response = try? response() {
                // No server error, save to local storage and return response
                _ = try? LocalStorage.saveTrips(response)
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

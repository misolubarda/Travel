//
//  FlightsRequest.swift
//  Travel
//
//  Created by Miso Lubarda on 20/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

@objc class FlightsAPIRequest: NSObject, APIRequestProtocol {
    
    /// Required by protocol (see APIRequestProtocol)
    var baseURL: NSURL
    /// Required by protocol (see APIRequestProtocol)
    var responseQueue: dispatch_queue_t
    /// Required by protocol (see APIRequestProtocol)
    var dataTask: NSURLSessionDataTask? = nil
    /// Required by protocol (see APIRequestProtocol)
    var endpointPath: String {
        return "w60i"
    }
    
    /// Required by protocol (see APIRequestProtocol)
    var responseParsing: ((data: NSData) throws -> [BusTrip]) = { (data) in
        guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [[String: AnyObject]] else {
            throw FlightsAPIRequestError.JSONRootArrayFromData
        }
        
        var trips = [BusTrip]()
        
        for jsonDict in jsonArray {
            let busTrip = try BusTrip(JSONDict: jsonDict)
            trips.append(busTrip)
        }
        
        return trips
    }
    
    /**
     Initializes request.
     
     - parameter baseURL: Base url of the request.
     - parameter responseQueu: Queue on which to provide response.
     
     - returns: Initialized request.
     */
    init(baseURL: NSURL, responseQueue: dispatch_queue_t) {
        self.baseURL = baseURL
        self.responseQueue = responseQueue
    }
}

extension FlightsAPIRequest {
    enum FlightsAPIRequestError: ErrorType {
        case JSONRootArrayFromData
    }
}


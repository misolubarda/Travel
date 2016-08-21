//
//  TrainsRequest.swift
//  Travel
//
//  Created by Miso Lubarda on 20/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

@objc class TrainsAPIRequest: NSObject, APIRequestProtocol {
    
    /// Required by protocol (see APIRequestProtocol)
    var baseURL: NSURL
    /// Required by protocol (see APIRequestProtocol)
    var responseQueue: dispatch_queue_t
    /// Required by protocol (see APIRequestProtocol)
    var dataTask: NSURLSessionDataTask? = nil
    /// Required by protocol (see APIRequestProtocol)
    var endpointPath: String {
        return "3zmcy"
    }
    
    /// Required by protocol (see APIRequestProtocol)
    var responseParsing: ((data: NSData) throws -> [TrainTrip]) = { (data) in
        guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [[String: AnyObject]] else {
            throw TrainsAPIRequestError.JSONRootArrayFromData
        }
        
        var trips: [TrainTrip] = try jsonArray.map {
            try TrainTrip(JSONDict: $0)
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

extension TrainsAPIRequest {
    enum TrainsAPIRequestError: ErrorType {
        case JSONRootArrayFromData
    }
}

//
//  BusesRequest.swift
//  Travel
//
//  Created by Miso Lubarda on 20/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

@objc class BusesAPIRequest: NSObject, APIRequestProtocol {
    
    /// Required by protocol (see APIRequestProtocol)
    var baseURL: NSURL
    /// Required by protocol (see APIRequestProtocol)
    var responseQueue: dispatch_queue_t
    /// Required by protocol (see APIRequestProtocol)
    var dataTask: NSURLSessionDataTask? = nil
    /// Required by protocol (see APIRequestProtocol)
    var endpointPath: String {
        return "37yzm"
    }
    
    /// Required by protocol (see APIRequestProtocol)
    var responseParsing: ((data: NSData) throws -> String) = { (data) in
        return ""
    }
    
    /**
     Initializes request with query string.
     
     - parameter baseURL: Base url of the request.
     - parameter responseQueu: Queue on which to provide response.
     
     - returns: Request for user query.
     */
    init(baseURL: NSURL, responseQueue: dispatch_queue_t) {
        self.baseURL = baseURL
        self.responseQueue = responseQueue
    }
}

extension BusesAPIRequest {
    enum BusesAPIRequestError: ErrorType {
        case StringFromData, JSONResultsMissing
    }
}

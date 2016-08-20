//
//  APIProtocol.swift
//  Travel
//
//  Created by Miso Lubarda on 20/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import Foundation

/**
 *  Protocol defines API request data, parsing function and response data.
 */
protocol APIRequestProtocol: class {
    
    /// This defines the type of response data.
    associatedtype ResponseType
    
    /// Base URL of the request.
    var baseURL: NSURL {get}
    
    /// Endpoint URL path, relative to baseURL
    var endpointPath: String {get}
    
    /// Queue on which to provide response.
    var responseQueue: dispatch_queue_t {get}
    
    /// This function parses response from NSData to specified response type.
    var responseParsing: ((data: NSData) throws -> ResponseType) {get}
    
    /// Reference to NSURLSessionDataTask created when configuring the request
    var dataTask: NSURLSessionDataTask? {get set}
    
}

extension APIRequestProtocol {
    
    /**
     Configuring request with resulting NSURLSessionDataTask response on a provided queue with completion block which throws ErrorType if NSURLSession returns NSError.
     
     Usage without error rethrow:
     
     apiRequest.prepareWithCompletion() { (response: () throws -> NSData)
     do {
     let response = try response()
     // Continue using response.
     
     } catch let error {
     // Handle error
     
     }
     }
     
     Usege with error rethrow:
     
     //Inside a funciton that throws error
     
     apiRequest.prepareWithCompletion() { (response: () throws -> NSData)
     
     let response = try response()
     // Continue using response.
     
     }
     
     
     - parameter completion: Completion returns APIResponse or throws error if NSURLSession returns NSError.
     */
    func prepareWithCompletion(completion: (response: () throws -> ResponseType) -> Void) {
        let session = NSURLSession.sharedSession()
        guard let url = NSURL(string: endpointPath, relativeToURL: baseURL) else {
            completion(response: { throw APIRequestError.URL })
            return
        }
        dataTask = session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            dispatch_async(self.responseQueue, {
                if error == nil {
                    if let data = data {
                        do {
                            let response = try self.responseParsing(data: data)
                            completion(response: { return response})
                        } catch let error {
                            completion(response: { throw error })
                        }
                    } else {
                        completion(response: { throw APIRequestError.NoData })
                    }
                } else {
                    completion(response: { throw APIRequestError.Response(message: error?.localizedDescription) })
                }
            })
        }
    }
    
    /**
     Execute the request and invoke completion block, specified in prepareWithCompletion function.
     */
    func execute() {
        dataTask?.resume()
    }
}

enum APIRequestError: ErrorType {
    case URL, Response(message: String?), NoData
}

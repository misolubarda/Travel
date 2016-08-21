//
//  TravelUnitTests.swift
//  TravelUnitTests
//
//  Created by Miso Lubarda on 20/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import XCTest

class APIRequestTests: XCTestCase {
    
    var busTripsData: NSData?
    
    override func setUp() {
        super.setUp()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBusAPIRequestParsing() {
        
        let busAPIRequest = BusesAPIRequest(baseURL: NSURL(), responseQueue: dispatch_get_main_queue())
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("BusesJSONString", ofType: "txt")
        let data = NSFileManager.defaultManager().contentsAtPath(path!)
        
        let trips = try! busAPIRequest.responseParsing(data: data!)
        
        XCTAssertTrue(trips.count == 100)
        
        let trip1 = trips[0]
        let departureString = Helper.dateFormatter().stringFromDate(trip1.departureTime)
        let arrivalString = Helper.dateFormatter().stringFromDate(trip1.arrivalTime)
        let logoUrlString = trip1.providerLogo.absoluteString
        
        XCTAssertTrue(trip1.vehicleID == 1)
        XCTAssertTrue(departureString == "2:41")
        XCTAssertTrue(arrivalString == "16:56")
        XCTAssertTrue(trip1.priceInEuro == 5.48)
        XCTAssertTrue(logoUrlString == "http://cdn-goeuro.com/static_content/web/logos/63/postbus.png")
        XCTAssertTrue(trip1.stops == 2)
    }

    func testFlightsBusAPIRequestParsing() {
        
        let flightsAPIRequest = FlightsAPIRequest(baseURL: NSURL(), responseQueue: dispatch_get_main_queue())
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("FlightsJSONString", ofType: "txt")
        let data = NSFileManager.defaultManager().contentsAtPath(path!)
        
        let trips = try! flightsAPIRequest.responseParsing(data: data!)
        
        XCTAssertTrue(trips.count == 30)
        
        let trip1 = trips[0]
        let departureString = Helper.dateFormatter().stringFromDate(trip1.departureTime)
        let arrivalString = Helper.dateFormatter().stringFromDate(trip1.arrivalTime)
        let logoUrlString = trip1.providerLogo.absoluteString
        
        XCTAssertTrue(trip1.vehicleID == 1)
        XCTAssertTrue(departureString == "1:23")
        XCTAssertTrue(arrivalString == "19:55")
        XCTAssertTrue(trip1.priceInEuro == 38.88)
        XCTAssertTrue(logoUrlString == "http://cdn-goeuro.com/static_content/web/logos/63/air_berlin.png")
        XCTAssertTrue(trip1.stops == 0)
    }
    
    func testTrainsBusAPIRequestParsing() {
        
        let trainsAPIRequest = TrainsAPIRequest(baseURL: NSURL(), responseQueue: dispatch_get_main_queue())
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("TrainsJSONString", ofType: "txt")
        let data = NSFileManager.defaultManager().contentsAtPath(path!)
        
        let trips = try! trainsAPIRequest.responseParsing(data: data!)
        
        XCTAssertTrue(trips.count == 20)
        
        let trip1 = trips[0]
        let departureString = Helper.dateFormatter().stringFromDate(trip1.departureTime)
        let arrivalString = Helper.dateFormatter().stringFromDate(trip1.arrivalTime)
        let logoUrlString = trip1.providerLogo.absoluteString
        
        XCTAssertTrue(trip1.vehicleID == 1)
        XCTAssertTrue(departureString == "2:59")
        XCTAssertTrue(arrivalString == "15:12")
        XCTAssertTrue(trip1.priceInEuro == 61.2)
        XCTAssertTrue(logoUrlString == "http://cdn-goeuro.com/static_content/web/logos/63/deutsche_bahn.png")
        XCTAssertTrue(trip1.stops == 3)
    }
}

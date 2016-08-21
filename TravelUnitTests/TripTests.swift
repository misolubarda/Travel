//
//  TripTests.swift
//  Travel
//
//  Created by Miso Lubarda on 21/08/16.
//  Copyright © 2016 test. All rights reserved.
//

import XCTest

class TripTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTripEncodingDecoding() {
        
        let dict = ["id": 1, "provider_logo" : "http://test.test", "price_in_euros" : 13.3, "departure_time" : "3:33", "arrival_time": "12:34", "number_of_stops": 2]
        
        let flightTrip = try! FlightTrip(JSONDict: dict)
        
        let dictToStore = flightTrip.exportToJSONDict()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(dictToStore, forKey: "testTripEncodingDecoding")
        let dictFromStore = defaults.objectForKey("testTripEncodingDecoding") as! [String: AnyObject]
        
        let flightTripFromStore = try! FlightTrip(JSONDict: dictFromStore)
        
        XCTAssertTrue(flightTrip.vehicleID == flightTripFromStore.vehicleID)
        XCTAssertTrue(flightTrip.providerLogo == flightTripFromStore.providerLogo)
        XCTAssertTrue(flightTrip.priceInEuro == flightTripFromStore.priceInEuro)
        XCTAssertTrue(flightTrip.departureTime == flightTripFromStore.departureTime)
        XCTAssertTrue(flightTrip.arrivalTime == flightTripFromStore.arrivalTime)
        XCTAssertTrue(flightTrip.stops == flightTripFromStore.stops)
    }
}


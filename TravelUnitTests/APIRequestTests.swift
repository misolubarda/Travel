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
        
        let busTrips = try! busAPIRequest.responseParsing(data: data!)
        
        XCTAssertTrue(busTrips.count == 100)
        
        let busTrip1 = busTrips[0]
        let departureString = Helper.dateFormatter().stringFromDate(busTrip1.departureTime)
        let arrivalString = Helper.dateFormatter().stringFromDate(busTrip1.arrivalTime)
        let logoUrlString = busTrip1.providerLogo.absoluteString
        
        XCTAssertTrue(busTrip1.vehicleID == 1)
        XCTAssertTrue(departureString == "2:41")
        XCTAssertTrue(arrivalString == "16:56")
        XCTAssertTrue(busTrip1.priceInEuro == 5.48)
        XCTAssertTrue(logoUrlString == "http://cdn-goeuro.com/static_content/web/logos/63/postbus.png")
        XCTAssertTrue(busTrip1.stops == 2)
    }    
}

//
//  LocationTests.swift
//  ToDoAppTests
//
//  Created by Nodirbek Khudoyberdiev on 02/01/23.
//

import XCTest
@testable import ToDoApp
import CoreLocation

final class LocationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override class func tearDown() {
        super.tearDown()
        
    }
    
    func testInitWithCoordinates(){
        let coordinate = CLLocationCoordinate2D(latitude: 1,
                                    longitude: 1)
        let location = Location(name: "Foo",
                                coordinate: coordinate)
        XCTAssertEqual(coordinate.latitude, location.coordinate?.latitude)
        XCTAssertEqual(coordinate.longitude, location.coordinate?.longitude)
    }
    
    func testInitSetsName(){
        let location = Location(name: "AFSdsad")
        XCTAssertNotEqual(location.name, "", "Location name must not be empty")
    }
}

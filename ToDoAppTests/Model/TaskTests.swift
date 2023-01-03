//
//  TaskTests.swift
//  ToDoAppTests
//
//  Created by Nodirbek Khudoyberdiev on 01/01/23.
//

import XCTest
@testable import ToDoApp

final class TaskTests: XCTestCase {
    

    func testInitTaskWithTitle(){
        let task = Task(title: "Foo")
        XCTAssertNotNil(task)
    }
    
    func testInitTaskWithTitleAndDescription(){
        let task = Task(title: "Foo", description: nil)
        XCTAssertNil(task.description)
    }
    
    func testTaskTileIsSame(){
        let task = Task(title: "Foo")
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testTaskDateNotNil(){
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date, "Task date must not be nil")
    }
    
    func testWhenGivenLocationSetsLocation(){
        let location = Location(name: "Foo")
        
        let task = Task(title: "Baz",
                        description: "Baz",
                        location: location)
        XCTAssertEqual(location, task.location)
    }

    
}

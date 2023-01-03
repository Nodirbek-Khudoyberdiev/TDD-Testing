//
//  DataProviderTests.swift
//  ToDoAppTests
//
//  Created by Nodirbek Khudoyberdiev on 03/01/23.
//

import XCTest
@testable import ToDoApp

final class DataProviderTests: XCTestCase {
    
    var sut: DataProvider!
    var tableView: UITableView!

    override func setUp() {
        super.setUp()
        sut = DataProvider()
        tableView = UITableView()
        tableView.dataSource = sut
        sut.taskManager = TaskManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testNumberOfSectionsIsTwo(){
        tableView.dataSource = sut
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2) 
    }
    
    func testNumberOfRowsInSectionZeroIsZero(){
        
        sut.taskManager?.add(task: Task(title: "Foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.add(task: Task(title: "BAR"))
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    
    func testNumberOfRowsInSectionOneIsDoneTaskCount(){
        sut.taskManager?.add(task: Task(title: "Fooo"))
        sut.taskManager?.checkTask(at: 0)
        sut.taskManager?.add(task: Task(title: "Foo"))
        sut.taskManager?.checkTask(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    
    
}

//
//  TaskListViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Nodirbek Khudoyberdiev on 02/01/23.
//

import XCTest
@testable import ToDoApp

final class TaskListViewControllerTests: XCTestCase {
    
    var sut: TaskListViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        sut = vc as? TaskListViewController
        sut.loadViewIfNeeded()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTableViewIsNotNilWhenViewIsLoaded(){
        XCTAssertNotNil(sut.tableView)
        
    }
    
    func testDataProviderIsNotNilWhenViewIsLoaded(){
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateIsSet(){
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
}

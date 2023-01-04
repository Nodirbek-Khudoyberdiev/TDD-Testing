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
    var controller: TaskListViewController!

    override func setUp() {
        super.setUp()
        sut = DataProvider()
        sut.taskManager = TaskManager()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        controller = storyBoard.instantiateViewController(withIdentifier: TaskListViewController.id) as? TaskListViewController
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTaskManagerIsNotNil(){
        XCTAssertNotNil(sut.taskManager)
    }
    
    func testNumberOfSectionsIsTwo(){
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
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.taskManager?.add(task: Task(title: "Foo"))
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRowAtIndexPathReturnsTaskCell(){
        sut.taskManager?.add(task: Task(title: "Foo"))
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is TaskCell)
    }
    
    func testCellForRowAtIndexPathDequeuesCellFromTableView(){
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        sut.taskManager?.add(task: Task(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellIsDequeued)
        
    }
    
    func testCellForRowInSectionZeroCallsConfigure(){
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        let task = Task(title: "Foo")
        sut.taskManager?.add(task: task)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell
        cell.configure(withTask: task)
        XCTAssertEqual(cell.task, task)
    }
    
    func testCellForRowInSectionOneCallsConfigure(){
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        let task = Task(title: "Foo")
        let taskTwo = Task(title: "Nodir")
        sut.taskManager?.add(task: task)
        sut.taskManager?.add(task: taskTwo)
        sut.taskManager?.checkTask(at: 0)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        cell.configure(withTask: task)
        XCTAssertEqual(cell.task, task)
    }
    
    func testDoneButtonTitleForSectionZeroShowsDone(){
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual("Done", buttonTitle)
    }
    
    func testDoneButtonTitleForSectionOneShowsDone(){
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual("Undone", buttonTitle)
    }
    
    func testCheckingTaskChecksInTaskManager(){
        let task = Task(title: "Foo")
        sut.taskManager?.add(task: task)
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(sut.taskManager?.tasksCount, 0)
        XCTAssertEqual(sut.taskManager?.doneTasksCount, 1)
    }
    
    func testUnchecksInTaskManager(){
        let task = Task(title: "Foo")
        sut.taskManager?.add(task: task)
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1)) 
        XCTAssertEqual(sut.taskManager?.tasksCount, 1)
        XCTAssertEqual(sut.taskManager?.doneTasksCount, 0)
    }
    
}

extension DataProviderTests {
    class MockTableView: UITableView {
        var cellIsDequeued = false
        
        static func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 350, height: 450))
            mockTableView.dataSource = dataSource
            mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: TaskCell.id)
            return mockTableView
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
    }
    
    class MockTaskCell: TaskCell {
        var task: Task?
        
        override func configure(withTask task: Task) {
            self.task = task
        }
        
    }
    
}

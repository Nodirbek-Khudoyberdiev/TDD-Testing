//
//  TaskManagerTests.swift
//  ToDoAppTests
//
//  Created by Nodirbek Khudoyberdiev on 02/01/23.
//

import XCTest
@testable import ToDoApp

final class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!
    
    override func setUp() {
        super.setUp()
        sut = TaskManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitTaskManagerWithZeroTests(){
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    func testInitTaskManagerWithZeroDoneTests(){
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    func testAddTaskIncrementTaskCount(){
        let task = Task(title: "Foo")
        sut.add(task: task)
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    func testTaskAtIndexAddedTask(){
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        let returnedTask = sut.task(at: 0)
        XCTAssertEqual(task.title, returnedTask.title)
    }
    
    func testUncheckingTest(){
        let task = Task(title: "Fooo")
        sut.add(task: task)
        sut.checkTask(at: 0)
        sut.uncheckTask(at: 0)
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    func testCheckTaskAtIndexChangesCount(){
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTasksCount, 1)
    }
    
    func testCheckedTaskRemovedFromTasks(){
        let firstTask = Task(title: "Nodir")
        let secondTask = Task(title: "Bar")
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.task(at: 0), secondTask)
    }
    
    func testDoneTaskAtReturnsCheckedTask(){
        let task = Task(title: "Nodir")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(returnedTask, task)
    }
    
    func testRemoveAllResultsCountToBeZero(){
        sut.add(task: Task(title: "Nodir"))
        sut.add(task: Task(title: "Nodir1"))
        sut.checkTask(at: 0)
        
        sut.removeAll()
        
        XCTAssertEqual(sut.doneTasksCount, 0)
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    func testAddingSameDoesntIncrementCount(){
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Foo"))
        XCTAssertTrue(sut.tasksCount == 1)
    }
    
}

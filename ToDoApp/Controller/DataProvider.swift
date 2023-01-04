//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Nodirbek Khudoyberdiev on 03/01/23.
//

import UIKit

private enum Section: Int {
    case toDo
    case done
}

class DataProvider: NSObject {
    
    var taskManager: TaskManager?
    
}

extension DataProvider: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError()
        }
        guard let taskManager else { return 0 }
        switch section {
        case .toDo:
            return taskManager.tasksCount
        case .done:
            return taskManager.doneTasksCount
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.id, for: indexPath) as! TaskCell
        if let task = taskManager?.task(at: indexPath.row) {
            cell.configure(withTask: task)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard let section = Section(rawValue: indexPath.section) else { return ""}
        switch section {
        case .toDo: return "Done"
        case .done: return "Undone"
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section), let taskManager else { return }
        switch section {
        case .toDo:
            taskManager.checkTask(at: indexPath.row)
        case .done:
            taskManager.uncheckTask(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
}


protocol Reusable {
    static var id: String { get }
}

extension Reusable {
    static var id: String {
        return String(describing: self)
    }
}

extension NSObject: Reusable { }

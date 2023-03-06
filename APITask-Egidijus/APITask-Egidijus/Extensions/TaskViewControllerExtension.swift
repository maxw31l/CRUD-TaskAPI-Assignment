//
//  TaskViewControllerExtension.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-06.
//

import UIKit

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return userTasksArray.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: ListCell.identifier)
    cell.textLabel?.text = userTasksArray[indexPath.row].title
    cell.detailTextLabel?.text = userTasksArray[indexPath.row].description

    return cell
  }
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.beginUpdates()
      let url = URL(string: "http://134.122.94.77/api/Task/\(String(describing: self.userTasksArray[indexPath.row].id))")!

      TaskServiceAPI.deleteTask(url: url) { result in

        switch result {
          case .success(_):
            tableView.deleteRows(at: [], with: .fade)

            self.userTasksArray.remove(at: indexPath.row)
            tableView.reloadData()
          case .failure(_):
            UIAlertController.showErrorAlert(title: "Error", message: "Something's wrong", controller: self.self)
        }
      }
      tableView.endUpdates()
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let selectedTaskId = self.userTasksArray[indexPath.row].id

    updateTaskVC.taskId = selectedTaskId
    navigationController?.pushViewController(updateTaskVC, animated: true)
  }
}

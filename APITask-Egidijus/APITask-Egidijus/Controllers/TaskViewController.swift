//
//  TaskViewController.swift
//  Project-TaskAPI-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-02-28.
//

import UIKit

class TaskViewController: UIViewController {

  var updateTaskVC: UpdateTaskViewController!
  var textField: UITextField?
  var tabBarVC: TabBarViewController!
  var user: NewUserId?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()

    tableView.delegate = self
    tableView.dataSource = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.navigationItem.title = "Tasks"

    self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "plus.app"),
      style: .done,
      target: self,
      action: #selector(presentCreateTask)
      )
    if let userId = user?.userId {
      TaskServiceAPI.fetchingUserTasks(url: URLBuilder.getTaskURL(withId: userId)) { [weak self] task in
        self?.userTasksArray = task.tasks
        self?.tableView.reloadData()
      }
    }
  }

  var userTasksArray: [Task] = []
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    tableView.allowsSelection = true

    return tableView
  }()

  @objc func presentCreateTask() {
  
//    var newTitleText: String?
//    var newDescriptionText: String?
//    var newEstimateMinutes: Int?

    //ALERTS
      let alertTitle = UIAlertController(title: "Add a task", message: "Insert title", preferredStyle: .alert)

      alertTitle.addTextField {  textField in
        textField.placeholder = "Title"
//        textField.text = newTitleText
        self.tableView.reloadData()
      }

    let alertDescription = UIAlertController(title: "Add a task", message: "Insert description", preferredStyle: .alert)
      alertDescription.addTextField { textField in
        textField.placeholder = "Description"
//        textField.text = newDescriptionText
        self.tableView.reloadData()
      }

      let alertEstimatedMinutes = UIAlertController(title: "Add a task", message: "Insert estimated minutes", preferredStyle: .alert)
    alertEstimatedMinutes.addTextField { minutesTextField in

      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textField {
          let allowedCharacters = "0123456789"
          let allowedCharactersSet = CharacterSet(charactersIn: allowedCharacters)
          let typedCharactersSet = CharacterSet(charactersIn: allowedCharacters)
          let typedCharactersIn = CharacterSet(charactersIn: string)
          let numbers = allowedCharactersSet.isSuperset(of: typedCharactersIn)
          return numbers
        }
        return true
      }

          var theText = minutesTextField.text ?? ""
          var minutesInt = Int(theText) ?? 0
          self.tableView.reloadData()

      minutesTextField.placeholder = "Estimated minutes"
//          minutesInt = newEstimateMinutes ?? 5
      }

      //ALERT OPTIONS
      let titleOptionNext = UIAlertAction(title: "Next", style: .default) { nextPressed in

        if nextPressed.isEnabled {
          self.present(alertDescription, animated: true)
        }
      }

      let descriptionOptionNext = UIAlertAction(title: "Next", style: .default) { nextPressed in

        if nextPressed.isEnabled {
          self.present(alertEstimatedMinutes, animated: true)
        }
      }

      let minutesOptionNext = UIAlertAction(title: "Cancel", style: .default) { nextPressed in

        if nextPressed.isEnabled {
          self.present(alertDescription, animated: true)
        }
      }

      let optionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      }

    let optionDone = UIAlertAction(title: "Done", style: .default) { [self] (action) in

        guard let alertTextFields = alertTitle.textFields, alertTextFields.count == 1,
              let descriptionTextFields = alertDescription.textFields, descriptionTextFields.count == 1,
              let minutesTextFields = alertEstimatedMinutes.textFields, minutesTextFields.count == 1
        else {
return
        }

        let newTitle = alertTextFields[0]
        let newDescription = descriptionTextFields[0]
        let newMinutes = minutesTextFields[0]

        guard let title = newTitle.text, !title.isEmpty,
               let description = newDescription.text, !description.isEmpty,

             let minutes = newMinutes.text, !minutes.isEmpty,
              let text = newMinutes.text,
              let newMinutesInt = Int(text)
        else {
return
        }

        TaskServiceAPI.createTask(title: title, description: description , estimateMinutes: newMinutesInt
, assigneeId: self.user?.userId ?? -1) { [weak self] result in
          guard let self else { return }
          
          print("mano dabartinis user id yra: \(self.user?.userId ?? -1)")

          switch result {
            case .success(let newTask):
              print("added new task with id: \(newTask.taskId)")
              if let userId = self.user?.userId {
                self.updateTaskVC.user?.userId = userId
                TaskServiceAPI.fetchingUserTasks(url: URLBuilder.getTaskURL(withId: userId)) { [weak self] task in
                  self?.userTasksArray = task.tasks
                  self?.tableView.reloadData()
                }
              }
            case .failure(let error):
              print(error.localizedDescription)
          }
        }

      self.tableView.reloadData()
      }

      self.present(alertTitle, animated: true)
      alertTitle.addAction(titleOptionNext)
      alertTitle.addAction(optionCancel)

      self.present(alertDescription, animated: true)
      alertDescription.addAction(descriptionOptionNext)
      alertDescription.addAction(optionCancel)

      self.present(alertEstimatedMinutes, animated: true)
      alertEstimatedMinutes.addAction(minutesOptionNext)
      alertEstimatedMinutes.addAction(optionDone)
    self.tableView.reloadData()
  }

  private func setupUI() {
    self.tabBarController?.navigationItem.title = "Tasks"
    self.view.backgroundColor = .systemBlue
    self.view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo:
                                      self.view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo:
                                          self.view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo:
                                          self.view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo:
                                            self.view.trailingAnchor)
    ])
  }
}



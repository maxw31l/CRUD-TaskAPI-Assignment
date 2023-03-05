//
//  TaskViewController.swift
//  Project-TaskAPI-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-02-28.
//

import UIKit

protocol reloadTableViewDelegate {
func reloadRequired()
}

class TaskViewController: UIViewController {
let updateTaskVC = UpdateTaskViewController()
  var delegate: reloadTableViewDelegate?
//  @objc let createTaskVC = createTaskViewController()

  struct taskAccessRequest: Encodable {
    let taskId: Int
  }

  var tabBarVC: TabBarViewController!

  var user: NewUserId?

  var userTasksArray: [Task] = []
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    tableView.allowsSelection = true

    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()

    tableView.delegate = self
    tableView.dataSource = self


    if let userId = user?.userId {
      TaskServiceAPI.fetchingUserTasks(url: URLBuilder.getTaskURL(withId: userId)) { [weak self] task in
        self?.userTasksArray = task.tasks
      }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.setupNavBar()


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

  override func viewDidAppear(_ animated: Bool) {

//    super.viewDidAppear(animated)
//    if let userId = user?.userId {
//      TaskServiceAPI.fetchingUserTasks(url: URLBuilder.getTaskURL(withId: userId)) { [weak self] task in
//        self?.userTasksArray = task.tasks
//      }
//    }


  }

  @objc func presentCreateTask() {



print("som")

  
    var newTitleText: String?
    var newDescriptionText: String?
    var newEstimateMinutes: Int?


//    //ALERTS
      let alertTitle = UIAlertController(title: "Add a task", message: "Insert title", preferredStyle: .alert)


      alertTitle.addTextField {  textField in
        textField.placeholder = "Title"
        textField.text = newTitleText
        self.tableView.reloadData()

        print("LALALALLA \(String(describing: newTitleText))")
      }

      let alertDescription = UIAlertController(title: "Add a task", message: "Insert description", preferredStyle: .alert)
      alertDescription.addTextField { textField in
        textField.placeholder = "Description"
        textField.text = newDescriptionText
        self.tableView.reloadData()

        print(newDescriptionText)
      }

      let alertEstimatedMinutes = UIAlertController(title: "Add a task", message: "Insert estimated minutes", preferredStyle: .alert)
      alertEstimatedMinutes.addTextField { textField in
        var theText = textField.text ?? ""
        var minutesInt = Int(theText) ?? 0
        self.tableView.reloadData()

        textField.placeholder = "Estimated minutes"
        minutesInt = newEstimateMinutes ?? 5
        print(newEstimateMinutes)


      }

      //OPTIONS
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

      let optionDone = UIAlertAction(title: "Done", style: .default) { (action) in

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
print("Empty textField")
return
        }
        print(newTitle)

        TaskServiceAPI.createTask(title: title, description: description , estimateMinutes: newMinutesInt
, assigneeId: self.user?.userId ?? -1) { [weak self] result in
          guard let self else { return }
          
          print("mano dabartinis user id yra: \(self.user?.userId ?? -1)")

          switch result {
            case .success(let newTask):
              self.tableView.reloadData()
              print("added new task with id: \(newTask.taskId)")
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
  }







  private func setupNavBar() {

    self.tabBarController?.navigationItem.title = "Tasks"

  }



  private func setupUI() {
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




  @IBAction func taskListButtonTapped(_ sender: UIButton) {
  }


  @IBAction func userButtonTapped(_ sender: Any) {
  }

  func addTextField(configurationHandler: ((UITextField) -> Void)? = nil) {
    
  }

  let urlPath = URL(string: "http://134.122.94.77/api/Task/248")!

}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(userTasksArray.count)
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
        print(url)
        let taskId = userTasksArray[indexPath.row].id

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
    navigationController?.pushViewController(updateTaskVC, animated: true)
  }


}


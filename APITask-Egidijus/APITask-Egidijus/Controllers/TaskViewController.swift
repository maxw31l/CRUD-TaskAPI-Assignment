//
//  TaskViewController.swift
//  Project-TaskAPI-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-02-28.
//

import UIKit

class TaskViewController: UIViewController {

  struct taskAccessRequest: Encodable {
    let taskId: Int
  }
  
  var user: NewUserId?

  var userTasksArray: [Task] = []
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    tableView.allowsSelection = true

    return tableView
  }()

  override func viewDidLoad() {
    self.tableView.reloadData()
    super.viewDidLoad()
    self.setupUI()
    self.tableView.delegate = self
    self.tableView.dataSource = self

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let userId = user?.userId {
      TaskServiceAPI.fetchingUserTasks(url: URLBuilder.getTaskURL(withId: userId)) { [weak self] task in
        self?.userTasksArray = task.tasks
        self?.tableView.reloadData()
      }
    }
    self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "plus.app"),
      style: .done,
      target: self,
      action: #selector(addTapped))
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

  

  override func viewWillAppear(_ animated: Bool) {
    self.setupNavBar()
  }

  //MARK: Properties
  @objc func addTapped(_ sender: UIBarButtonItem) {

    //ALERTS
    let alertTitle = UIAlertController(title: "Add a task", message: "Insert title", preferredStyle: .alert)

    alertTitle.addTextField {  textField in

      if let text = textField.text {
        print(text)
      }


      textField.placeholder = "Title"


//      if let txtField = alertTitle.textFields?.first, let text = txtField.text {
//        // operations
//        print("Text==> \(text)")
//      }
    }

    let alertDescription = UIAlertController(title: "Add a task", message: "Insert description", preferredStyle: .alert)
    alertDescription.addTextField { textField in
      textField.placeholder = "Description"
//      let text = textField.text
//      print(text)

    }

    let alertEstimatedMinutes = UIAlertController(title: "Add a task", message: "Insert estimated minutes", preferredStyle: .alert)
    alertEstimatedMinutes.addTextField { textField in
      textField.placeholder = "Estimated minutes"
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


    }

    present(alertTitle, animated: true)
    alertTitle.addAction(titleOptionNext)
    alertTitle.addAction(optionCancel)

    present(alertDescription, animated: true)
    alertDescription.addAction(descriptionOptionNext)
    alertDescription.addAction(optionCancel)

    present(alertEstimatedMinutes, animated: true)
    alertEstimatedMinutes.addAction(minutesOptionNext)
    alertEstimatedMinutes.addAction(optionDone)
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

        TaskServiceAPI.deleteTask(url: urlPath) { result in
          switch result {
            case .success(_):
              tableView.deleteRows(at: [], with: .fade)
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
    print("cell tapped")
  }


}


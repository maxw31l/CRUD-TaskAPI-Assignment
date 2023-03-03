//
//  TaskViewController.swift
//  Project-TaskAPI-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-02-28.
//

import UIKit

class TaskViewController: UIViewController {

//  let taskServiceAPI = TaskServiceAPI.shared


    var user: User?

  var userTasksArray: [Task] = [Task(id: 1, title: "test", description: "description", estimateMinutes: 15, loggedTime: 3, isDone: true)]

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .systemBackground
    tableView.allowsSelection = true

    return tableView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let userId = user?.userId {
            TaskServiceAPI.fetchingUserTasks(url: URLBuilder.getTaskURL(withId: userId)) { [weak self] task in
                self?.userTasksArray.append(contentsOf: task.tasks)
                self?.tableView.reloadData()
            }
        }
    }



  private func setupNavBar() {
    self.tabBarController?.navigationItem.title = "Tasks"
    self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "plus.app"),
      style: .done,
      target: self,
      action: #selector(addTapped))
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
  @objc func addTapped() {
  }

  @IBAction func taskListButtonTapped(_ sender: UIButton) {
  }

  @IBAction func userButtonTapped(_ sender: Any) {
  }

  func addTextField(configurationHandler: ((UITextField) -> Void)? = nil) {
    
  }

}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userTasksArray.count
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard var cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier,
//                                                   for: indexPath) as? ListCell else {
//      fatalError("The TableView could not dequeue a Cell in TaskViewController") }
//
//    cell.textLabel?.text = userTasksArray[indexPath.row].title
//    cell.detailTextLabel?.text = userTasksArray[indexPath.row].description
//    return cell

    let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: ListCell.identifier)
        cell.textLabel?.text = userTasksArray[indexPath.row].title
        cell.detailTextLabel?.text = userTasksArray[indexPath.row].description

    return cell
  }

  //
  //  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
  //    <#code#>
  //  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    print("cell tapped")
  }
}


//guard var cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier,
//                                               for: indexPath) as? ListCell else {
//  fatalError("The TableView could not dequeue a Cell in TaskViewController") }
//
//cell.textLabel?.text = userTasksArray[indexPath.row].title
//cell.detailTextLabel?.text = userTasksArray[indexPath.row].description
//return cell

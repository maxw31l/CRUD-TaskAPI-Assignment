//
//  UpdateTaskViewController.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-05.
//

import UIKit


class UpdateTaskViewController: UIViewController {
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var minutesTextField: UITextField!
  @IBOutlet weak var timeTextField: UITextField!
  @IBOutlet weak var updateButton: UIButton!

  let taskVC = TaskViewController()
  var taskId: Int?
  var user: NewUserId?

  func setupPlaceholders() {
    titleTextField.placeholder = "Title"
    descriptionTextField.placeholder = "Description"
    minutesTextField.placeholder = "Estimated minutes"
    timeTextField.placeholder = "Logged time"
  }

  @IBAction func updateButtonTapped(_ sender: Any) {

    guard let userId = self.user?.userId, let taskId = self.taskId else { return }

    let newTitleText: String?
    let newDescriptionText: String?
    let newEstimateMinutes: Int?
    let newLoggedTime: Int?
    let isDone: Bool? = false

    let theMinutesText = minutesTextField.text ?? ""
    let theLoggedText = timeTextField.text ?? ""

    newTitleText = titleTextField.text
    newDescriptionText = descriptionTextField.text
    newEstimateMinutes = Int(theMinutesText) ?? 0
    newLoggedTime = Int(theLoggedText) ?? 0

    guard let newTitleText = newTitleText, !newTitleText.isEmpty,
          let newDescriptionText = newDescriptionText, !newDescriptionText.isEmpty,
          let newEstimateMinutes = newEstimateMinutes,
          let newLoggedTime = newLoggedTime,
          let isDone = isDone else { return }

    TaskServiceAPI.updateTask(id: taskId,
                              title: newTitleText,
                              description: newDescriptionText,
                              estimateMinutes: newEstimateMinutes,
                              assigneeId: userId,
                              loggedTime: newLoggedTime,
                              isDone: isDone) {  [weak self] result in
      guard let self = self  else {
        return }

      switch result {
        case .success(_):
          UIAlertController.showErrorAlert(title: "Success!",
                                           message: "Your task was updated",
                                           controller: self)
        case .failure(let error):
          UIAlertController.showErrorAlert(title: "Error with status code: \(error.statusCode)",
                                           message: error.localizedDescription,
                                           controller: self)
          self.navigationController?.dismiss(animated: true)
          self.tabBarController?.dismiss(animated: false)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.rowHeight = 55.0
    updateButton.layer.shadowRadius = 4
    adjustButton()
    setupPlaceholders()
  }

  func adjustButton() {
    updateButton.layer.cornerRadius = 20
    updateButton.layer.shadowRadius = 4
    updateButton.layer.shadowColor = UIColor.black.cgColor
    updateButton.layer.shadowOffset = CGSize(width: 2, height: 4)
    updateButton.layer.shadowOpacity = 0.7
  }

  let tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false

    return table
  }()

  let dataTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.font = UIFont.systemFont(ofSize: 20)

    return textField
  }()

  func initTableView(){
    view.addSubview(tableView)
    tableView.backgroundColor = .systemBackground
    tableView.separatorStyle = .singleLine

    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: updateButton.topAnchor)

    ])
  }
}

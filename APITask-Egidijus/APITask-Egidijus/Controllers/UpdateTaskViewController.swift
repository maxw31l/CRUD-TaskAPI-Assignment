//
//  UpdateTaskViewController.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-05.
//

import UIKit


class UpdateTaskViewController: UIViewController {


let taskVC = TaskViewController()

  var taskId: Int?
  var user: NewUserId?
  
  @IBOutlet weak var titleTextField: UITextField!

  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var minutesTextField: UITextField!
  @IBOutlet weak var timeTextField: UITextField!
  @IBOutlet weak var updateButton: UIButton!



  func setupPlaceholders() {
    titleTextField.placeholder = "Title"
    descriptionTextField.placeholder = "Description"
    minutesTextField.placeholder = "Estimated minutes"
    timeTextField.placeholder = "Logged time"
  }


  @IBAction func updateButtonTapped(_ sender: Any) {

    guard let userId = self.user?.userId, let taskId = self.taskId else { return }
    print(userId)
    print(taskId)

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



    print("Data from text fields: \(String(describing: newTitleText)), \(String(describing: newDescriptionText)), \(String(describing: newEstimateMinutes)), \(String(describing: newLoggedTime)), \(String(describing: isDone))")

    TaskServiceAPI.updateTask(id: taskId, title: newTitleText, description: newDescriptionText, estimateMinutes: newEstimateMinutes, assigneeId: userId, loggedTime: newLoggedTime, isDone: isDone) {  [weak self] result in
       guard let self = self  else {
         print("mano dabartinis task id yra: \(taskId)")
         return }

       print("mano dabartinis task id yra: \(String(describing: taskId))")

       switch result {
         case .success(_):
//           print("added new task with id: \(updatedTask.taskId)")
           UIAlertController.showErrorAlert(title: "Success!", message: "Your task was updated", controller: self)
//           tableView.reloadData()
//           self.navigationController?.dismiss(animated: true)
         case .failure(let error):
           UIAlertController.showErrorAlert(title: "Error with status code: \(error.statusCode)", message: error.localizedDescription, controller: self)
           self.navigationController?.dismiss(animated: true)
           self.tabBarController?.dismiss(animated: false)
      print("error \(error.localizedDescription)")
           print("error \(error.statusCode)")
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
    tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.identifier)
    tableView.register(TitleViewCell.self, forCellReuseIdentifier: TitleViewCell.identifier)
    tableView.register(LoggedTimeCell.self, forCellReuseIdentifier: LoggedTimeCell.identifier)
    tableView.register(EstimatedMinutesCell.self, forCellReuseIdentifier: EstimatedMinutesCell.identifier)

      view.addSubview(tableView)
      tableView.dataSource = self
    tableView.backgroundColor = .systemBackground

       // MARK: Remove the separator from tableView
    tableView.separatorStyle = .singleLine


      // #3
      NSLayoutConstraint.activate([
          tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
          tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
          tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//          tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
          tableView.bottomAnchor.constraint(equalTo: updateButton.topAnchor)



      ])
  }

  }


extension UpdateTaskViewController: UITableViewDataSource, UITableViewDelegate {


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {



  guard let titleCell = tableView.dequeueReusableCell(withIdentifier: TitleViewCell.identifier, for: indexPath) as! TitleViewCell? else { return UITableViewCell() }

  tableView.indexPath(for: titleCell)

  let descriptionCell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as! DescriptionCell?



  let estimatedMinutesCell = tableView.dequeueReusableCell(withIdentifier: EstimatedMinutesCell.identifier, for: indexPath) as! EstimatedMinutesCell?


  let loggedTimeCell = tableView.dequeueReusableCell(withIdentifier: LoggedTimeCell.identifier, for: indexPath) as! LoggedTimeCell?




   let tf = UITextField(frame: CGRect(x: 20, y: 0, width: 300, height: 20))


//
//   tf.placeholder = "Enter text here"
//   tf.font = UIFont.systemFont(ofSize: 15)
//  titleCell?.contentView.addSubview(tf)
//  titleCell?.addSubview(tf)


//  descriptionCell?.placeholder = "Description"
  return UITableViewCell()
}



func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }

  func numberOfSections(in tableView: UITableView) -> Int {


    return 1
  }




}









//class UpdateTaskViewController: UITableViewController {
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = .systemBackground
//    tableView.register(UITableViewCell.self, forCellReuseIdentifier: UpdateTaskCell.identifier)
//    setupTableView()
//
//}
//
//  let submitButton: UIButton = {
//let submitButton = UIButton()
//
//    return submitButton
//  }()
//
//  let dataTextField: UITextField = {
//      let textField = UITextField()
//      textField.translatesAutoresizingMaskIntoConstraints = false
//      textField.font = UIFont.systemFont(ofSize: 20)
//      return textField
//  }()
//
//  func setupTableView() {
//    tableView.allowsSelection = false
//    tableView.register(UpdateTaskCell.self, forCellReuseIdentifier: UpdateTaskCell.identifier)
//    NSLayoutConstraint.activate([
//        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//    ])
//  }
//
////  func initConstraints(){
////
////    viewDidLayoutSubviews()
////    viewWillLayoutSubviews()
////    dataTextField.cons
////    dataTextField = NSLayoutConstraint.activate([
////          dataTextField.heightAnchor.constraint(equalToConstant: 40),
////          dataTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
////          dataTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
////          dataTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
////          dataTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
////      ])
////
////  }
//
//  let placeholderData = ["taskId", "taskTitle", "description", "estimateMinutes", "loggedTime", "isDone"]
//}
//
//extension UpdateTaskViewController {
//  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: UpdateTaskCell.identifier, for: indexPath)
//
//    return cell
//  }
//
//  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 4
//  }
//
//
//}

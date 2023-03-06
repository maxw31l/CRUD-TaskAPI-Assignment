//
//  UpdateTaskViewController.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-05.
//

import UIKit


class UpdateTaskViewController: UIViewController {

  var taskId: Int?
  var user: NewUserId?
  
  @IBOutlet weak var titleTextField: UITextField!

  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var minutesTextField: UITextField!
  @IBOutlet weak var timeTextField: UITextField!
  @IBOutlet weak var updateButton: UIButton!

  var newTitleText: String?
  var newDescriptionText: String?
  var newEstimateMinutes: Int?
  var newLoggedTime: Int?
  var isDone: Bool? 

  @IBAction func updateButtonTapped(_ sender: Any) {

   if let minutesTextField = minutesTextField, let timeTextField = timeTextField {
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if textField == textField {
         let allowedCharacters = "0123456789"
         let allowedCharactersSet = CharacterSet(charactersIn: allowedCharacters)
         let typedCharactersSet = CharacterSet(charactersIn: allowedCharacters)
         let typedCharactersIn = CharacterSet(charactersIn: string)
         let numbers = allowedCharactersSet.isSuperset(of: typedCharactersSet)
         return numbers
       }
       return true
     }



         var theMinutesText = minutesTextField.text ?? ""
     var theLoggedText = timeTextField.text ?? ""
         var minutesInt = Int(theMinutesText) ?? 0
     var timeInt = Int(theLoggedText) ?? 0
         self.tableView.reloadData()

     minutesTextField.placeholder = "Estimated minutes"
     timeTextField.placeholder = "Logged time"
         timeInt = newLoggedTime ?? 5
         minutesInt = newEstimateMinutes ?? 5
         print(newEstimateMinutes)

////////////////////////////////////////////////////////////
//     guard let alertTextFields = alertTitle.textFields, alertTextFields.count == 1,
//           let descriptionTextFields = alertDescription.textFields, descriptionTextFields.count == 1,
//           let minutesTextFields = alertEstimatedMinutes.textFields, minutesTextFields.count == 1
//     else {
//return
//     }

//     let newTitle = alertTextFields[0]
//     let newDescription = descriptionTextFields[0]
//     let newMinutes = minutesTextFields[0]

     guard let title = titleTextField.text, !title.isEmpty,
            let description = descriptionTextField.text, !description.isEmpty,

           let estimatedMinutesText = minutesTextField.text, !estimatedMinutesText.isEmpty,
           let loggedTime = timeTextField.text, !loggedTime.isEmpty,
           let newLoggedTimeInt = Int(loggedTime),
           let newEstimatedMinutesInt = Int(estimatedMinutesText)
     else {
print("Empty textField")
return
     }

     if let userId = self.user?.userId {
       TaskServiceAPI.updateTask(id: self.taskId ?? -1, title: title, description: description, estimateMinutes: newEstimatedMinutesInt, assigneeId: userId, loggedTime: newLoggedTimeInt, isDone: false) { [weak self] result in
        guard let self else { print("griztu",
                                    print("mano dabartinis task id yra: \(String(describing: self?.taskId))"))
          return }

        print("mano dabartinis task id yra: \(String(describing: self.taskId))")

        switch result {
          case .success(let updatedTask):
            print("added new task with id: \(updatedTask.taskId)")
            UIAlertController.showErrorAlert(title: "Success!", message: "Your task was updated", controller: self)
            self.tableView.reloadData()
          case .failure(let error):
            UIAlertController.showErrorAlert(title: "Error with status code: \(String(describing: error.statusCode))", message: error.localizedDescription, controller: self)
            print("error \(error.localizedDescription)")
            print("error \(error.statusCode)")
        }

      }
     }


   }



  }
  override func viewDidLoad() {
    super.viewDidLoad()
//    initTableView()
    self.tableView.rowHeight = 55.0
    updateButton.layer.shadowRadius = 4
    adjustButton()
  }

  override func viewWillAppear(_ animated: Bool) {
    print("Idomu: \(taskId)")
  }

//  override func viewDidAppear(_ animated: Bool) {
//    print("Idomu: \(selectedTaskId)")
//  }

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

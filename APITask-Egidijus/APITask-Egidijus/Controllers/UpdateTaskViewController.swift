//
//  UpdateTaskViewController.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-05.
//

import UIKit


class UpdateTaskViewController: UIViewController {


  @IBOutlet weak var updateButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    initTableView()
    self.tableView.rowHeight = 55.0
    updateButton.layer.shadowRadius = 4
    adjustButton()
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
    tableView.register(UpdateTaskCell.self, forCellReuseIdentifier: UpdateTaskCell.identifier)
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
  let cell = tableView.dequeueReusableCell(withIdentifier: UpdateTaskCell.identifier, for: indexPath) as! UpdateTaskCell?
  cell?.selectionStyle = .none

   let tf = UITextField(frame: CGRect(x: 20, y: 0, width: 300, height: 20))
   tf.placeholder = "Enter text here"
   tf.font = UIFont.systemFont(ofSize: 15)


  cell?.contentView.addSubview(tf)
  cell?.addSubview(tf)




  return cell ?? UITableViewCell()
  }

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
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

////
////  createTaskViewController.swift
////  APITask-Egidijus
////
////  Created by Egidijus Vaitkevičius on 2023-03-05.
////
//
//import Foundation
//import UIKit
//
//protocol createTaskDelegate {
//  func didSTapCreateTask(didTap: UITabBarItem )
//}
//
//
//class createTaskViewController: UIViewController {
//
//  var qqButton: UIBarButtonItem!
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    print("appeared")
//    print("Kazka")
//
//  }
//
//
//  override func viewDidAppear(_ animated: Bool) {
//    print("appeared")
//    print("Kazka")
//  }
//
//
//
//
//
//
//
//
//
//  @objc func plusButtonTapped(_ sender: AnyObject) {
//
//    print("Kazka")
//  //ALERTS
//  let alertTitle = UIAlertController(title: "Add a task", message: "Insert title", preferredStyle: .alert)
//
//
//  alertTitle.addTextField {  textField in
//
//    if let text = textField.text {
//      print(text)
//    }
//
//
//    textField.placeholder = "Title"
//
//
////      if let txtField = alertTitle.textFields?.first, let text = txtField.text {
////        // operations
////        print("Text==> \(text)")
////      }
//  }
//
//  let alertDescription = UIAlertController(title: "Add a task", message: "Insert description", preferredStyle: .alert)
//  alertDescription.addTextField { textField in
//    textField.placeholder = "Description"
////      let text = textField.text
////      print(text)
//
//  }
//
//  let alertEstimatedMinutes = UIAlertController(title: "Add a task", message: "Insert estimated minutes", preferredStyle: .alert)
//  alertEstimatedMinutes.addTextField { textField in
//    textField.placeholder = "Estimated minutes"
//  }
//  //OPTIONS
//  let titleOptionNext = UIAlertAction(title: "Next", style: .default) { nextPressed in
//
//    if nextPressed.isEnabled {
//      self.present(alertDescription, animated: true)
//    }
//  }
//
//  let descriptionOptionNext = UIAlertAction(title: "Next", style: .default) { nextPressed in
//
//    if nextPressed.isEnabled {
//      self.present(alertEstimatedMinutes, animated: true)
//    }
//  }
//
//  let minutesOptionNext = UIAlertAction(title: "Cancel", style: .default) { nextPressed in
//
//    if nextPressed.isEnabled {
//      self.present(alertDescription, animated: true)
//    }
//  }
//
//  let optionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//  }
//
//  let optionDone = UIAlertAction(title: "Done", style: .default) { (action) in
//
//
//  }
//
//  present(alertTitle, animated: true)
//  alertTitle.addAction(titleOptionNext)
//  alertTitle.addAction(optionCancel)
//
//  present(alertDescription, animated: true)
//  alertDescription.addAction(descriptionOptionNext)
//  alertDescription.addAction(optionCancel)
//
//  present(alertEstimatedMinutes, animated: true)
//  alertEstimatedMinutes.addAction(minutesOptionNext)
//  alertEstimatedMinutes.addAction(optionDone)
//  }
//}

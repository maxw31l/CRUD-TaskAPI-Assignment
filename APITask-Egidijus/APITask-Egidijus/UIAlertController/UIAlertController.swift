//
//  UIAlertController.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-02.
//

import UIKit

extension UIAlertController {

  static func showErrorAlert(title: String, message: String, controller: UIViewController) {

    let action = UIAlertAction(title: "Ok", style: .default)

    let alert =  UIAlertController(title:title, message: message, preferredStyle: .alert)
    alert.addAction(action)

    controller.present(alert, animated: true)

  }
  //
  //  static func showError(title: String, message: String) {
  //    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil) // update req handler bus completion, kai completina, atsidaro kitas alertra,  o cancel atveju completion nil.
  //    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
  //    alertController.addAction(alertAction)
  //  }

//  func newTaskAlert() {
//    let alertTitle = UIAlertController(title: "Add a task", message: "Insert title", preferredStyle: .alert)
//    alertTitle.addTextField { textField in
//      textField.placeholder = "Title"
//    }
//
//    let optionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//    }
//
//    let optionNext = UIAlertAction(title: "Next", style: .default) { [self] nextPressed in
//
//      if nextPressed.isEnabled {
//
//        alertTitle.dismiss(animated: false)
//        alertTitle.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        present(alertDescription(), animated: <#T##Bool#>)
//        print("Diss")
//
//
//      }
//
//
//
//
//    }
//    present(alertTitle, animated: true)
//    alertTitle.addAction(optionNext)
//    alertTitle.addAction(optionCancel)
//
//
//  }
//
//  func alertDescription() {
//    let alertDescription = UIAlertController(title: "Add a task", message: "Insert description", preferredStyle: .alert)
//    alertDescription.addTextField { textField in
//      if let txtField = alertDescription.textFields?.first, let text = txtField.text {
//        // operations
//        print("Text==>" + text)
//        textField.placeholder = "Description"
//      }
//
//      let optionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//      }
//
//      let optionNext = UIAlertAction(title: "Next", style: .default) { nextPressed in
//
//        if nextPressed.isEnabled {
//          self.present(alertDescription, animated: true)
//        }
//
//      }
//      self.present(alertDescription, animated: true)
//      alertDescription.addAction(optionNext)
//      alertDescription.addAction(optionCancel)

//      //    return alertDescription
//    }
//
//    func alertEstimatedMinutes() {
//      let alertEstimatedMinutes = UIAlertController(title: "Add a task", message: "Insert estimated minutes", preferredStyle: .alert)
//      alertEstimatedMinutes.addTextField { textField in
//        textField.placeholder = "Estimated minutes"
//      }
//
//      let optionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//      }
//
//      let optionDone = UIAlertAction(title: "Done", style: .default) { (action) in
//
//
//      }
//      present(alertEstimatedMinutes, animated: true)
//      alertEstimatedMinutes.addAction(optionDone)
//      alertEstimatedMinutes.addAction(optionCancel)
//    }
//
//  }

  ////////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
//  var messages: [String] = ["Insert title", "Insert description", "Insert estimated minutes" ]
//
//
//     private func showAlert() {
//          guard self.messages.count > 0 else { return }
//
//          let message = self.messages.first
//
//          func removeAndShowNextMessage() {
//              self.messages.removeFirst()
//              self.showAlert()
//          }
//
//          let alert = UIAlertController(title: "Add a task", message: message, preferredStyle: .alert)
//       let optionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//       }
//
//       let optionNext = UIAlertAction(title: "Next", style: .default) { nextPressed in
//
//         }
//       let optionDone = UIAlertAction(title: "Done", style: .default) { (action) in
//
//
//       }
//          alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//
//          alert.addAction(UIAlertAction(title: "Next", style: .default) { (action) in
//              print("pressed yes")
//
//
//              removeAndShowNextMessage()
//
//          })
//          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ (action) in
//              print("pressed no")
//
//
//              removeAndShowNextMessage()
//          })
//
//
//       present(alert, animated: false)
//
//
//      }


}

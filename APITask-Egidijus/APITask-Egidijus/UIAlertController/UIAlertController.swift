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


  
}


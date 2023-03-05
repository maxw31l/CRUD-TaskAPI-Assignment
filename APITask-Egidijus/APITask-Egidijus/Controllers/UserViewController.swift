//
//  UserViewController.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-02.
//

import UIKit

class UserViewController: UIViewController {

  var user: NewUserId?

  
  @IBOutlet weak var usernameLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    usernameLabel.text = user?.username
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.navigationItem.title = "User"
    self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "trash"),
      style: .done,
      target: self,
      action: #selector(trashTapped))
    self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = .red
  }
  
  @objc func trashTapped() {
    let optionNo = UIAlertAction(title: "No", style: .default) { (action) in
    }

    let optionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
    }

    let optionYes = UIAlertAction(title: "Yes", style: .destructive) { [weak self] (action) in
      guard let self = self else { return }
      let urlPath = URL(string: "http://134.122.94.77/api/User/\(String(describing: self.user?.userId ?? -1))")!

      TaskServiceAPI.deleteUser(url: urlPath) { result in
        switch result {
          case .success(_):
            self.navigationController?.setViewControllers([AuthenticationViewController()], animated: true)
          case .failure(_):
              UIAlertController.showErrorAlert(title: "Error", message: "Something's wrong", controller: self.self)
        }
      }
    }

    let alertController = UIAlertController(title: "Do you want to delete user?", message: nil, preferredStyle: .actionSheet)
    alertController.addAction(optionNo)
    alertController.addAction(optionYes)
    alertController.addAction(optionCancel)

    self.present(alertController, animated: true) {
    }
  }
}

extension UserViewController {
  func showAlertWithDismiss() {
    let alertController = UIAlertController(title: "Deleted!", message: "Please register again", preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "Ok", style: .default) { _ in
      self.dismiss(animated: true, completion: nil)
    }
    alertController.addAction(dismissAction)
    self.present(alertController, animated: true)
  }
}

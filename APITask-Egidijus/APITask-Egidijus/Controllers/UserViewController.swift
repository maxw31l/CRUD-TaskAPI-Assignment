//
//  UserViewController.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-02.
//

import UIKit

class UserViewController: UIViewController {

  var user: User?
  
  @IBOutlet weak var usernameLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    usernameLabel.text = user?.username
  }
  
  @objc func trashTapped() {
    let optionNo = UIAlertAction(title: "No", style: .default) { (action) in
    }

    let optionCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
    }

    let optionYes = UIAlertAction(title: "Yes", style: .destructive) { [weak self] (action) in

      let urlPath = URL(string: "http://134.122.94.77/api/user/\(String(describing: self?.user?.userId))")!
      TaskServiceAPI.delete(url: urlPath) { res in
        switch res {
          case .success(_):
            DispatchQueue.main.async {
              self?.showAlertWithDismiss()
            }


          case .failure(_):
            DispatchQueue.main.async {
              //                    self.showAlert("Failure", message: "User wasn't deleted")
              UIAlertController.showError(title: "Error", message: "Something's wrong")
            }
            print(self?.user as Any)
        }
      }
    }

    let alert = UIAlertController(title: "Do you want to delete user?", message: nil, preferredStyle: .actionSheet)
    alert.addAction(optionNo)
    alert.addAction(optionYes)
    alert.addAction(optionCancel)

    self.present(alert, animated: true) {
      // The alert was presented
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.navigationItem.title = "User"
    //    navigationController?.navigationBar.backgroundColor = .systemGray6
    self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "trash"),
      style: .done,
      target: self,
      action: #selector(trashTapped))
    self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = .red
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

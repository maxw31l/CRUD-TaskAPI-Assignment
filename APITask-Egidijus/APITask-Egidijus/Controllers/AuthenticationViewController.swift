//
//  AuthenticationViewController.swift
//  Project-TaskAPI-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-02-28.
//

import UIKit

class AuthenticationViewController: UIViewController {

  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var actionButton: UIButton!
  @IBOutlet weak var signLoginButton: UIButton!
  @IBOutlet weak var questionLabel: UILabel!

  let taskBarNav = TabBarViewController()

  struct Request: Encodable {
    let username: String
    let password: String
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func setupUI() {
    actionButton.layer.shadowRadius = 4
    actionButton.layer.shadowColor = UIColor.black.cgColor
    actionButton.layer.shadowOffset = CGSize(width: 2, height: 4)
    actionButton.layer.shadowOpacity = 0.7

    let adjustedPasswordField = CGFloat(2 * Double.pi / 180)
    passwordTextField.layer.transform = CATransform3DMakeRotation(adjustedPasswordField, 0, 0, 1)

    let adjustedButton = CGFloat(-1 * Double.pi / 180)
    signLoginButton.layer.transform = CATransform3DMakeRotation(adjustedButton, 0, 0, 1)
  }

  enum State {
    case register
    case login
  }

  var currentState: State = .login
  var stateIndex: Int = 1

  @IBAction func signLoginButtonTapped(_ sender: Any) {
    if stateIndex >= 1 {
      stateIndex -= 1
    } else {
      stateIndex += 1
    }

    if stateIndex == 0 {
      currentState = .register
    } else if stateIndex == 1 {
      currentState = .login
    }

    switch currentState {
      case .login:
        actionButton.setTitle("Login", for: .normal)
        questionLabel.text = "Have no username?"
        signLoginButton.setTitle("Register!", for: .normal)
      case .register:
        actionButton.setTitle("Register", for: .normal)
        questionLabel.text = "Already registered?"
        signLoginButton.setTitle("Login!", for: .normal)
    }
  }

  @IBAction func actionButtonTapped(_ sender: Any) {
    switch currentState {
      case .register:
        register()

      case .login:
        login()
    }
  }

  func register() {
    TaskServiceAPI.registerUser(username: usernameTextField.text!,
                                password: passwordTextField.text!) { [weak self] result in
      guard let self else { return }


      switch result {
        case .success(let user):
          self.taskBarNav.setUser(user)
          self.navigationController?.setViewControllers([self.taskBarNav], animated: true)
        case .failure(let error):
          UIAlertController.showErrorAlert(title: error.message ?? "",
                                           message: "Error with status code: \(error.statusCode)",
                                           controller: self)
      }
    }
  }
  
  func login() {
    TaskServiceAPI.loginUser(username: usernameTextField.text!, password: passwordTextField.text!) { [weak self] result in
      guard let self else { return }
      switch result {
        case .success(let user):
          self.taskBarNav.setUser(user)
          self.navigationController?.setViewControllers([self.taskBarNav], animated: true)
        case .failure(let error):
          UIAlertController.showErrorAlert(title: error.message ?? "",
                                           message: "Error with status code: \(error.statusCode)",
                                           controller: self)
      }
    }
  }
}


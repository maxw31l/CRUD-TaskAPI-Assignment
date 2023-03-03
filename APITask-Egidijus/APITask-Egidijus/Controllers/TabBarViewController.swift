//
//  ViewController.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-01.
//

import UIKit


class TabBarViewController: UITabBarController {

    let tasksVC = TaskViewController()
    let userVC = UserViewController()

  override func viewDidLoad() {
    super.viewDidLoad()

    tasksVC.title = "Tasks"
    userVC.title = "User"
    self.setViewControllers([tasksVC, userVC], animated: false)

    guard let items = self.tabBar.items else { return }
    let images = ["rectangle.dock", "person"]
    for image in 0...1 {
      items[image].image = UIImage(systemName: images[image])
    }
    
    self.tabBar.backgroundColor = .systemGray6
  }
  
    func setUser(_ user: User) {
        tasksVC.user = user
//        userVC.user = user
    }

  @objc func addTapped() {

  }
}

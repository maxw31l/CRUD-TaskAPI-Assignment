//
//  UpdateTaskViewController.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-05.
//

import UIKit

class UpdateTaskViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: UpdateTaskCell.identifier)
  }


  
}

extension UpdateTaskViewController {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UpdateTaskCell.identifier, for: indexPath)
    return cell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
}

//
//  DescriptionCell.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-06.
//

import Foundation
import UIKit

class DescriptionCell: UITableViewCell {

  let updateTaskVC = UpdateTaskViewController()
 static let identifier = "description"

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)

  }
  var placeholder: String? {
  didSet {
           guard let item = placeholder else {return}
    updateTaskVC.dataTextField.placeholder = item
      }
  }

  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")

  }

}

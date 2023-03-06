//
//  TitleViewCell.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-06.
//

import UIKit

class TitleViewCell: UITableViewCell {


  let updateTaskVC = UpdateTaskViewController()
 static let identifier = "titleCell"

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

//
//  AccessRequest.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-03.
//

import UIKit

struct AccessRequest: Encodable {
  let username: String
  let password: String
}

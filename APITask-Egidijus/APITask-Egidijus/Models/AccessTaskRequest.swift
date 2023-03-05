//
//  AccessTaskRequest.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-05.
//

import Foundation

struct AccessTaskRequest: Encodable {
  var title: String
  var description: String
  var estimateMinutes: Int
  var assigneeId: Int
}

//
//  UpdateTask.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-05.
//

import Foundation

class UpdateTask: Encodable {
  let id: Int
  let title: String
  let description: String
  let estimateMinutes: Int
  let assigneeId: Int
  let loggedTime: Int
  let isDone: Bool

  init(id: Int, title: String, description: String, estimateMinutes: Int, assigneeId: Int, loggedTime: Int, isDone: Bool) {
    self.id = id
    self.title = title
    self.description = description
    self.estimateMinutes = estimateMinutes
    self.assigneeId = assigneeId
    self.loggedTime = loggedTime
    self.isDone = isDone
  }
}

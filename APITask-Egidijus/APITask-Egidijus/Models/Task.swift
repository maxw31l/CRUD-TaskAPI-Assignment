//
//  Task.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-02.
//

import Foundation

struct Tasks: Decodable {
  let tasks: [Task]
}

struct Task: Decodable {
  let id: Int
  let title: String
  let description: String
  let estimateMinutes: Int
  let loggedTime: Int
  let isDone: Bool
  let userInfo: UserInfo
}


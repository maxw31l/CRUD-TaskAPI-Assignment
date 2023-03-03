//
//  User.swift
//  Project-TaskAPI-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-02-28.
//

import Foundation

class User {
    var username: String
    var userId: Int

    init(username: String, userId: Int) {
        self.username = username
        self.userId = userId
    }
}

//
//  NetworkError.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-03.
//

import UIKit

struct NetworkError: Error {
  enum ErrorType {
    case badRequest
    case notFound
    case unknown
    case decodingFailed
  }

  let message: String?
  let statusCode: Int
  let errorType: ErrorType

  init(message: String? = "UnknownNew", statusCode: Int, errorType: ErrorType) {
    self.message = message
    self.statusCode = statusCode
    self.errorType = errorType
  }
}

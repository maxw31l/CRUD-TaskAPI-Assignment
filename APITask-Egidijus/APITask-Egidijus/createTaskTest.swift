//
//  createTaskTest.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-05.
//

import Foundation

//class NewTask {
//  var title: String
//  var description: String
//  var estimateMinutes: Int
//  var assigneeId: Int
//
//  init(title: String, description: String, estimateMinutes: Int, assigneeId: Int) {
//    self.title = title
//    self.description = description
//    self.estimateMinutes = estimateMinutes
//    self.assigneeId = assigneeId
//  }
//}
//
//struct AccessTaskRequest: Encodable {
//  var title: String
//  var description: String
//  var estimateMinutes: Int
//  var assigneeId: Int
//
//}
//
//class NewTaskId {
//    var taskId: Int
//
//    init(taskId: Int) {
//
//        self.taskId = taskId
//    }
//}
//
//class ServiceAPI {
//
//
//
//  struct taskAccessRequest: Encodable {
//    let taskId: Int
//  }
//
//
//  static func registerTask(title: String, description: String, estimateMinutes: Int, assigneeId: Int, completion: @escaping (Result<NewTaskId, NetworkError>) -> Void) {
//
//    let url = URL(string: "http://134.122.94.77/api/Task/")!
//
//    let registerRequest = AccessTaskRequest(title: title, description: description, estimateMinutes: estimateMinutes, assigneeId: assigneeId)
//
//    let data = try! JSONEncoder().encode(registerRequest)
//
//    TaskServiceAPI.postRequest(url: url, body: data) { result in
//      switch result {
//        case .success(let data):
//print(data)
//          struct RegisterResponse: Decodable {
//            let taskId: Int
//          }
//
//          guard let userResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
//            completion(.failure(.init(statusCode: -1, errorType: .decodingFailed)))
//            return
//          }
//
//          let newTaskId = NewTaskId(taskId: userResponse.taskId)
//          completion(.success(newTaskId))
//          print(newTaskId.taskId)
//
//        case .failure(let error):
//          completion(.failure(error))
//      }
//    }
//  }







//struct NewTaskIdUpdateId {
//    var taskId: Int
//
//    init(taskId: Int) {
//
//        self.taskId = taskId
//    }
//}

//class ServiceAPI {
//
//
//
//
//
//  static func updateTaskPlease(id: Int,
//                         title: String,
//                         description: String,
//                         estimateMinutes: Int,
//                         assigneeId: Int,
//                         loggedTime: Int,
//                         isDone: Bool, completion: @escaping (Result<NewTaskIdUpdateId, NetworkError>) -> Void) {
//    let url = URL(string: "http://134.122.94.77/api/Task/")!
//
//    let requestToUpdateTask = UpdateTask(id: id, title: title, description: description, estimateMinutes: estimateMinutes, assigneeId: assigneeId, loggedTime: loggedTime, isDone: isDone)
//
//    let data = try! JSONEncoder().encode(requestToUpdateTask)
//
//    TaskServiceAPI.putRequest(url: url, body: data) { result in
//      switch result {
//        case .success(let data):
//          print("updateTask data: \(data)")
//          struct updateResponse: Decodable {
//            let taskId: Int
//          }
//
//          struct taskResponse: Decodable {
//            let taskId: Int
//          }
//
//          guard let taskResponse = try? JSONDecoder().decode(taskResponse.self, from: data) else {
//            completion(.failure(.init(statusCode: -1, errorType: .decodingFailed)))
//            return
//          }
//
//          let newUpdatedTaskId = NewTaskIdUpdateId(taskId: taskResponse.taskId)
//          completion(.success(newUpdatedTaskId))
//          print(newUpdatedTaskId.taskId)
//
//        case .failure(let error):
//          completion(.failure(error))
//          print("error updating task: \(error.localizedDescription)")
//      }
//    }
//  }
//}
























//
//  struct taskAccessRequest: Encodable {
//    let taskId: Int
//  }
//
//
//  static func registerTask(title: String, description: String, estimateMinutes: Int, assigneeId: Int, completion: @escaping (Result<NewTaskId, NetworkError>) -> Void) {
//
//    let url = URL(string: "http://134.122.94.77/api/Task/")!
//
//    let registerRequest = AccessTaskRequest(title: title, description: description, estimateMinutes: estimateMinutes, assigneeId: assigneeId)
//
//    let data = try! JSONEncoder().encode(registerRequest)
//
//    TaskServiceAPI.postRequest(url: url, body: data) { result in
//      switch result {
//        case .success(let data):
//          print(data)
//          struct RegisterResponse: Decodable {
//            let taskId: Int
//          }
//
//          guard let userResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
//            completion(.failure(.init(statusCode: -1, errorType: .decodingFailed)))
//            return
//          }
//
//          let newTaskId = NewTaskId(taskId: userResponse.taskId)
//          completion(.success(newTaskId))
//          print(newTaskId.taskId)
//
//        case .failure(let error):
//          completion(.failure(error))
//      }
//    }
//  }

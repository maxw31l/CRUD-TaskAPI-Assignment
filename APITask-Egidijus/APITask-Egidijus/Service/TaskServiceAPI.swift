//
//  TaskServiceAPI.swift
//  APITask-Egidijus
//
//  Created by Egidijus Vaitkevičius on 2023-03-01.
//


import UIKit

let baseURL = "http://134.122.94.77/api/"
let loginPath = "User/login"
let registerPath = "User/register"

class TaskServiceAPI {

  // GET
  public static func get(url: URL, completion: @escaping (Data?) -> Void) {
    URLSession.shared.dataTask(with: url) {
      data,
      response,
      error in
      guard let data else {
        completion(nil)
        return
      }

      completion(data)
    }.resume()
  }

  // POST
  public static func postRequest(url: URL, body: Data?, completion: @escaping (Result<Data, NetworkError>) -> Void) {

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = body
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    URLSession.shared.dataTask(with: request) {
      data,
      response,
      error in

      DispatchQueue.main.async {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard let data = data else {
          completion(.failure(.init(statusCode: statusCode, errorType: .unknown)))
          return
        }

        let dataString = String(data: data, encoding: .utf8)

        guard let httpResponse = response as? HTTPURLResponse else {
          completion(.failure(.init(statusCode: statusCode, errorType: .unknown)))
          return
        }

        switch httpResponse.statusCode {
          case 200:
            completion(.success(data))
          case 404:
            // ERROR NOT FOUND
            completion(.failure(.init(message: dataString, statusCode: statusCode, errorType: .notFound)))
          case 400:
            // ERROR BAD REQUEST
            completion(.failure(.init(message: dataString, statusCode: statusCode, errorType: .badRequest)))
          default:
            completion(.failure(.init(statusCode: statusCode, errorType: .unknown)))
        }
      }
    }.resume()
  }

  //PUT
  public static func putRequest(url: URL, body: Data?, completion: @escaping (Result<Data, NetworkError>) -> Void) {

    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.httpBody = body
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    URLSession.shared.dataTask(with: request) {
      data,
      response,
      error in

      DispatchQueue.main.async {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard let data = data else {
          completion(.failure(.init(statusCode: statusCode, errorType: .unknown)))
          return
        }

        let dataString = String(data: data, encoding: .utf8)

        guard let httpResponse = response as? HTTPURLResponse else {
          completion(.failure(.init(statusCode: statusCode, errorType: .unknown)))
          return
        }

        switch httpResponse.statusCode {
          case 200:
            completion(.success(data))
          case 404:
            // ERROR NOT FOUND
            completion(.failure(.init(message: dataString, statusCode: statusCode, errorType: .notFound)))
          case 400:
            // ERROR BAD REQUEST
            completion(.failure(.init(message: dataString, statusCode: statusCode, errorType: .badRequest)))
          default:
            completion(.failure(.init(statusCode: statusCode, errorType: .unknown)))
        }
      }
    }.resume()
  }

  static func registerUser(username: String, password: String, completion: @escaping (Result<NewUserId, NetworkError>) -> Void) {

    let url = URL(string: "http://134.122.94.77/api/user/register")!

    let registerRequest = AccessRequest(username: username, password: password)
    let data = try! JSONEncoder().encode(registerRequest)

    postRequest(url: url, body: data) { result in
      switch result {
        case .success(let data):

          struct RegisterResponse: Decodable {
            let userId: Int
          }

          guard let userResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
            completion(.failure(.init(statusCode: -1, errorType: .decodingFailed)))
            return
          }
          
          let user = NewUserId(username: username, userId: userResponse.userId)
          completion(.success(user))
          print(user.userId)

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  static func registerTask(title: String, description: String, estimateMinutes: Int, assigneeId: Int, completion: @escaping (Result<NewTaskId, NetworkError>) -> Void) {

    let url = URL(string: "http://134.122.94.77/api/Task/")!

    let registerRequest = AccessTaskRequest(title: title, description: description, estimateMinutes: estimateMinutes, assigneeId: assigneeId)

    let data = try! JSONEncoder().encode(registerRequest)

    TaskServiceAPI.postRequest(url: url, body: data) { result in
      switch result {
        case .success(let data):
print(data)
          struct RegisterResponse: Decodable {
            let taskId: Int
          }

          guard let userResponse = try? JSONDecoder().decode(RegisterResponse.self, from: data) else {
            completion(.failure(.init(statusCode: -1, errorType: .decodingFailed)))
            return
          }

          let newTaskId = NewTaskId(taskId: userResponse.taskId)
          completion(.success(newTaskId))
          print(newTaskId.taskId)

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  static func loginUser(username: String, password: String, completion: @escaping (Result<NewUserId, NetworkError>) -> Void) {

    let url = URL(string: "http://134.122.94.77/api/user/login")!

    let loginRequest = AccessRequest(username: username, password: password)
    let data = try! JSONEncoder().encode(loginRequest)

    postRequest(url: url, body: data) { result in
      switch result {
        case .success(let data):

          struct LoginResponse: Decodable {
            let userId: Int
          }

          guard let userResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
            completion(.failure(.init(statusCode: -1, errorType: .decodingFailed)))
            return
          }

          let user = NewUserId(username: username, userId: userResponse.userId)
          completion(.success(user))

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  static func updateTask(id: Int,
                         title: String,
                         description: String,
                         estimateMinutes: Int,
                         assigneeId: Int,
                         loggedTime: Int,
                         isDone: Bool, completion: @escaping (Result<NewTaskIdUpdateId, NetworkError>) -> Void) {
    let url = URL(string: "http://134.122.94.77/api/Task/")!

    let requestToUpdateTask = UpdateTask(id: id, title: title, description: description, estimateMinutes: estimateMinutes, assigneeId: assigneeId, loggedTime: loggedTime, isDone: isDone)

    let data = try! JSONEncoder().encode(requestToUpdateTask)

    TaskServiceAPI.putRequest(url: url, body: data) { result in
      switch result {
        case .success(let data):
          print("updateTask data: \(data)")

          struct updateResponse: Decodable {
            let taskId: Int
          }

          guard let taskResponse = try? JSONDecoder().decode(updateResponse.self, from: data) else {
            completion(.failure(.init(statusCode: -1, errorType: .decodingFailed)))
            return
          }

          let newUpdatedTaskId = NewTaskIdUpdateId(taskId: taskResponse.taskId)
          completion(.success(newUpdatedTaskId))
          print(newUpdatedTaskId.taskId)

        case .failure(let error):
          completion(.failure(error))
          print("error updating task: \(error.localizedDescription)")
      }
    }
  }

  static func deleteTask(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    var request = URLRequest(url: url)
  request.httpMethod = "DELETE"
  request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    URLSession.shared.dataTask(with: request) {
        data,
      response,
      error in

      DispatchQueue.main.async {
        guard let data else {
          let error = NSError(domain: "Error not found", code: 404)
          completion(.failure(error))
          return
        }
        completion(.success(data))
      }
    }.resume()
  }

  static func deleteUser(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {

      var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

      URLSession.shared.dataTask(with: request) {
          data,
        response,
        error in

        DispatchQueue.main.async {
          guard let data else {
            let error = NSError(domain: "Error not found", code: 404)
            completion(.failure(error))
            return
          }
          completion(.success(data))
        }
      }.resume()
  }

  func buildURL(urlPath: String) -> URL? {
    let baseURL = URL(string: baseURL)
    let createdURL = baseURL?.appending(path: urlPath)

    return createdURL
  }

  static func fetchingUserTasks(url: URL, completion: @escaping (Tasks) -> Void) {

    let session = URLSession.shared
    //http://134.122.94.77/api/Task/userTasks?userId=93 <--- Dokumentacija
    //http://134.122.94.77/api/Task/?userId=93 <--- MES
    let dataTask = session.dataTask(with: url) { data, response, error in
      DispatchQueue.main.async {
        guard let data = data else { return }
        do {
          let parsingData = try JSONDecoder().decode(Tasks.self, from: data)
          completion(parsingData)
        } catch {
//          print(error.localizedDescription)
        }
      }
    }
    dataTask.resume()
  }



}

struct URLBuilder {
  private static let kURLStringTask = "http://134.122.94.77/api/Task/"
  private static let kURLStringUser = "http://134.122.94.77/api/User/"
  static func getTaskURL() -> URL {
    URL(string: kURLStringTask)!
  }

  static func getTaskURL(withId id: Int) -> URL {
    URL(string: kURLStringTask + "userTasks?userId=\(id)")!
  }

  static func postTaskURL() -> URL {
    URL(string: kURLStringTask)!
  }

  static func deleteUserURL() -> URL {
    URL(string: kURLStringUser)!
  }

  static func deleteTaskURL() -> URL {
    URL(string: kURLStringUser)!
  }

  static func createTaskURL() -> URL {
    URL(string: kURLStringTask)!
  }

  
}

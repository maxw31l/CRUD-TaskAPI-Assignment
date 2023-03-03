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

//  static let shared = TaskServiceAPI()
//  private init() { }
  
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

  static func registerUser(username: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {

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
          
          let user = User(username: username, userId: userResponse.userId)
          completion(.success(user))

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

  static func loginUser(username: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {


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

          let user = User(username: username, userId: userResponse.userId)
          completion(.success(user))

        case .failure(let error):
          completion(.failure(error))
      }
    }
  }

 func buildURL(urlPath: String) -> URL? {
  let baseURL = URL(string: baseURL)

    let createdURL = baseURL?.appending(path: urlPath)

    print(createdURL ?? "")
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
        print(parsingData)
      } catch {
        print(error.localizedDescription)
        print("Catched")
      }
    }
  }
    dataTask.resume()
  }


  static func delete(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {

      var request = URLRequest(url: url)
      request.httpMethod = "DELETE"


      URLSession.shared.dataTask(with: request) {
          data, response, error in

          if let error = error {
              completion(.failure(error as Error))
          }
          guard let data else {
              let e = NSError(domain: "Data out of scope", code: 404)
              completion(.failure(e))
              return
          }
          completion(.success(data))
      }.resume()
  }

}




struct URLBuilder {
    private static let kURLString = "http://134.122.94.77/api/Task/"

    static func getTaskURL() -> URL {
        URL(string: kURLString)!
    }

    static func getTaskURL(withId id: Int) -> URL {
        URL(string: kURLString + "\(id)")!
    }

    static func postTaskURL() -> URL {
        URL(string: kURLString)!
    }
}

//
//  RequestsManager.swift
//  Kindling
//
//  Created by Eduardo Bernal on 04/08/21.
//

import Foundation

class RequestsManager {
    private static var defaultSession: URLSession =  {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        return URLSession(configuration: configuration)
    }()
    
    @discardableResult class func request<T: Codable>(_ request: URLRequestConvertible, completion: @escaping (Result<T, APIError>) -> ()) -> URLSessionDataTask? {
        guard let urlRequest = try? request.asURLRequest() else {
            completion(.failure(.badRequest))
            return nil
        }
        
        let sessionTask = RequestsManager.defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard let d = data else {
                    completion(.failure(.badResponse))
                    return
                }
                
                if let e = error {
                    completion(.failure(APIError(apiName: request.path, code: "\(e.code)", message: e.localizedDescription)))
                } else {
                    do {
                        let apiResponse = try JSONDecoder().decode(T.self, from: d)
                        completion(.success(apiResponse))
                    } catch {
                        if let responseString = String(data: d, encoding: .utf8) {
                            completion(.failure(APIError(apiName: request.path, code: "-1", message: responseString)))
                        } else {
                            completion(.failure(.badResponse))
                        }
                    }
                }
            }
        }
                
        sessionTask.resume()
                
        return sessionTask
    }
}

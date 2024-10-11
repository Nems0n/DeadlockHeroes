//
//  NetworkClien.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 05/10/2024.
//

import Foundation
import PromiseKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case customError(String)
}

public protocol NetworkClient {
    var request: URLRequest { get }
}

extension NetworkClient {
    func getRequest<T: Encodable>(with path: Endpoint, encodable data: T, httpMethod: RequestType) -> URLRequest {
        var request = getRequest(with: path, httpMethod: httpMethod)
        do {
            request.httpBody = try JSONEncoder().encode(data)
        } catch {
            print("JSON Encode Error")
        }
        return request
    }
    
    func getRequest(with path: Endpoint, httpMethod: RequestType) -> URLRequest {
        var request = URLRequest(url: API.getURL(with: path.path))
        request.httpMethod = httpMethod.rawValue
        API.getHeaders().forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return request
    }
    
    public func promise<T: Decodable>() -> Promise<T> {
        return Promise { seal in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    seal.reject(NetworkError.customError(error.localizedDescription))
                    return
                }
                
                guard let data else {
                    seal.reject(NetworkError.noData)
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    seal.fulfill(decodedData)
                } catch {
                    print(error.localizedDescription)
                    seal.reject(NetworkError.decodingError)
               }
            }.resume()
        }
    }
}

public extension NSError {
    static func error(with localizedDescription: String) -> NSError {
        NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}

public enum RequestType : String {
    /// HTTP GET request
    case GET
    /// HTTP POST request
    case POST
}


public struct AllHeroesResponse: Codable {
    let id: Int
    let name: String
}

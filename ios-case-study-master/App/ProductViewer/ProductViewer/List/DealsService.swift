//
//  NetworkService.swift
//  ProductViewer
//
//  Created by santhosh.kumar on 14/03/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

enum APIError: Error {
    case codableError
}

enum APIResult<T> {
    case success(T)
    case failure(Error)
}


final class DealsService: NSObject {
    
    let defaultSession: URLSession = URLSession(configuration: .default)
    
    typealias SerializationFunction<T> = (Data?, URLResponse?, Error?) -> APIResult<T>

    @discardableResult // ignore warning if return variable not used
    private func request<T: Decodable>(_ url: URL, serializationFunction: @escaping SerializationFunction<T>,
                            completion: @escaping (APIResult<T>) -> Void) -> URLSessionDataTask {
        let dataTask = defaultSession.dataTask(with: url) { data, response, error in
            let result: APIResult<T> = serializationFunction(data, response, error)
            DispatchQueue.main.async {
                completion(result)
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    @discardableResult
    func request<T: Decodable>(_ url: URL, completion: @escaping (APIResult<T>) -> Void) -> URLSessionDataTask {
        return request(url, serializationFunction: serializeJSON, completion: completion)
    }
    
    private func serializeJSON<T: Decodable>(with data: Data?, response: URLResponse?, error: Error?) -> APIResult<T> {
        if let error = error { return .failure(error) }
        guard let data = data else { return .failure(APIError.codableError) }
        do {
            let serializedValue = try JSONDecoder().decode(ServerResponse<T>.self, from: data)
            if let model: T = serializedValue.data {
                return .success(model)
            }
            else {
                return .failure(APIError.codableError)
            }

        } catch let error {
            return .failure(error)
        }
    }

}

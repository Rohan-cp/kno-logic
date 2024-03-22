//
//  DSService.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import Foundation

final class DSService {
    // Shared signleton instance
   static let shared = DSService()
    
    // Privatized constructor
    private init() {}
    
    enum DSServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    // Send dials API Request
    // - Params
    //    - Request:
    //    - Expecting:
    //    - Completion:
    public func execute<T: Codable>(_ request: DSRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(DSServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? DSServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    
    private func request(from dsRequest: DSRequest) -> URLRequest? {
        guard let url = dsRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = dsRequest.httpMethod
        return request
    }
}

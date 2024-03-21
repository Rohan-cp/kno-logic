//
//  DSRequest.swift
//  Dials
//
//  Created by Rohan Prashanth on 19/03/24.
//

import Foundation

// Object that represents a single API call
final class DSRequest {
    // API Constants
    private struct Constants {
        static let baseUrl = "http://localhost:8000/api"
    }
    
    // Desired Endpoints
    private let endpoint: DSEndpoint
    
    // Path components for API, if any
    private let pathComponents: [String]
    
    // Query parameters components for API, if any
    private let queryParameters: [URLQueryItem]
    
    // Constructed url for the api request in string format
    public var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            string += "?"
            let arguementString = queryParameters.compactMap({
                guard let value = $0.value else { return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += arguementString
        }
        return string
    }
    
    // Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    // Desired http method
    public let httpMethod = "GET"
    
    // MARK: - Public
    
    // Construct request
    // - Parameters:
    //    - endpoint: Target endpoint
    //    - pathComponents: Collection of path components
    //    - queryParameters: Collection of query parameters
    public init(endpoint: DSEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension DSRequest {
    static let articlesRequests = DSRequest(endpoint: .articles)
}

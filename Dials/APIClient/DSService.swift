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
    
    // Send dials API Request
    public func execute(_ request, completion: @escaping () => void) {
        
    }
}

//
//  StoriesError.swift
//  
//
//  Created by Igor Shelopaev on 04.07.2022.
//

import Foundation


/// Set of errors for input data validation
enum StoriesError : String, Error{
    
    case empty = "There are no stories"
    case duration = "Duration must be positive upper than zero"
    
    
    /// Validate input data
    /// - Returns: Error
    static func validate<D : IStory>(_ stories : [D]) -> StoriesError?  {
        if stories.isEmpty{
            return .empty
        }else if !stories.allSatisfy({ $0.duration > 0 }){
            return .duration
        }
        
        return nil
    }
    
}

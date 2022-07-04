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
}

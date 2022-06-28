//
//  StoriesState.swift
//  
//
//  Created by Igor Shelopaev on 24.06.2022.
//

import SwiftUI


/// Stories view states
enum StoriesState{
    
    case begin
    
    case next
    
    case suspend(CGFloat)
    
    case resume(CGFloat)
}

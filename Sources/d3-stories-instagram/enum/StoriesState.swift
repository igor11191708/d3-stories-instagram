//
//  StoriesState.swift
//  
//
//  Created by Igor Shelopaev on 24.06.2022.
//

import SwiftUI


/// Stories view states Inner data for managing stories view life circle
enum StoriesState{
    
    /// start
    case begin
    /// next story
    case next
    /// pause showing story
    case suspend(CGFloat)
    /// resume showing story
    case resume(CGFloat)
}

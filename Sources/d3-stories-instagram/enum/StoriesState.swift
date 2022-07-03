//
//  StoriesState.swift
//  
//
//  Created by Igor Shelopaev on 24.06.2022.
//

import SwiftUI


/// Stories view states Inner data for managing stories view life circle
public enum StoriesState: Equatable{
    
    /// before start
    case ready
    /// start of first stories, start of big circle
    case start
    /// begin
    case begin
    /// pause showing story
    case suspend(CGFloat)
    /// resume showing story
    case resume(CGFloat)
    ///end of a story
    case end
    ///end of all stories big circle
    case finish
}

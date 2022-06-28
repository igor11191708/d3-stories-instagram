//
//  IStoryTpl.swift
//  
//
//  Created by Igor Shelopaev on 28.06.2022.
//

import SwiftUI


/// Template view for a story
protocol IStoryTpl: View{
        
    associatedtype StoryType : IStory
    
    /// Current progress of showing story
    var progress: CGFloat { get }
    
    var story : StoryType { get }
}

//
//  IStoryTpl.swift
//  
//
//  Created by Igor Shelopaev on 28.06.2022.
//

import SwiftUI


/// Template view for a story
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 6.0, *)
public protocol IStoryTpl: View{
        
    associatedtype StoryType : IStory
    
    /// Current progress of showing story
    var progress: CGFloat { get }
    
    var story : StoryType { get }
}

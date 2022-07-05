//
//  CustomStoriesValidater.swift
//  
//
//  Created by Igor Shelopaev on 05.07.2022.
//

import Foundation

public struct CustomStoriesValidater: IStoriesValidater{
    
    public static func validate<T>(_ stories: [T]) -> [StoriesError] where T : IStory {
        
        var errors : [StoriesError] = []
        
        if let first = stories.first, first.duration < 0.5 {
            
            errors.append(.init(description: "The first story less than five seconds"))
        }
        
        return errors
    }
    
}

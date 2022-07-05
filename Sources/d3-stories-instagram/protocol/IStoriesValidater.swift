//
//  IStoriesValidater.swift
//  
//
//  Created by Igor Shelopaev on 05.07.2022.
//

import Foundation


public protocol IStoriesValidater{
           
    static func validate<T : IStory>(_ stories : [T] ) -> [StoriesError]
    
}

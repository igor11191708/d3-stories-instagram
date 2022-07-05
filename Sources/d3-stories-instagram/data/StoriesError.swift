//
//  StoriesError.swift
//  
//
//  Created by Igor Shelopaev on 05.07.2022.
//

import Foundation


/// Description for errors foind while validating ``IStory`` data set
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 6.0, *)
public struct StoriesError: IStoriesError {
       
    public let description: String
    
}

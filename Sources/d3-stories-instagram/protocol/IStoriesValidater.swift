//
//  IStoriesValidater.swift
//
//
//  Created by Igor Shelopaev on 05.07.2022.
//

import Foundation

/// Interface to validate input stories data for ``StoriesWidget``
@available(iOS 15.0, macOS 12.0, tvOS 16.0, watchOS 10.0, *)
public protocol IStoriesValidater {
    /// Check stories data
    /// - Parameter stories: Set of stories data
    /// - Returns: Errors
    static func validate<T: IStory>(_ stories: [T]) -> [StoriesError]
}

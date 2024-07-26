//
//  StoriesError.swift
//
//
//  Created by Igor Shelopaev on 05.07.2022.
//

import SwiftUI

/// Description for errors found while validating ``IStory`` data set
@available(iOS 15.0, macOS 12.0, tvOS 16.0, watchOS 7.0, *)
public struct StoriesError: IStoriesError {
    public let description: LocalizedStringKey
}

public extension StoriesError {
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(description)")
    }
}

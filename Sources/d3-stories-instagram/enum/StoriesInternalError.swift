//
//  StoriesError.swift
//
//
//  Created by Igor Shelopaev on 04.07.2022.
//

import SwiftUI

/// Set of errors for input data validation
enum StoriesInternalError: String, IStoriesValidater, IStoriesError {
    case empty = "empty_stories"

    case duration = "duration_error"

    var id: String {
        rawValue
    }

    /// Validate input data
    /// - Returns: ``StoriesError``
    static func validate<T>(_ stories: [T]) -> [StoriesError] where T: IStory {
        var errors = [StoriesError]()

        if stories.isEmpty {
            let e = empty
            errors.append(.init(description: e.description))
        }

        if !stories.allSatisfy({ $0.duration > 0 }) {
            let e = duration
            errors.append(.init(description: e.description))
        }

        return errors
    }

    /// Description for Tpl builder
    var description: LocalizedStringKey {
        LocalizedStringKey(rawValue)
    }
}

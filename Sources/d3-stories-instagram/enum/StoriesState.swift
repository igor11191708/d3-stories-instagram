//
//  StoriesState.swift
//
//
//  Created by Igor Shelopaev on 24.06.2022.
//

import SwiftUI

/// Stories view states Inner data for managing stories view life circle
@available(iOS 15.0, macOS 12.0, tvOS 16.0, watchOS 10.0, *)
public enum StoriesState: Equatable {
    /// Waiting to start If there's leeway this is the state during this delay before the big start
    case ready
    /// Start of first stories, start of big circle
    case start
    /// Begin
    case begin
    /// Pause showing story
    case suspend(CGFloat)
    /// Resume showing story
    case resume(CGFloat)
    /// End of a story
    case end
    /// End of all stories big circle
    case finish
}

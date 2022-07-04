//
//  StoriesWidget.swift
//
//
//  Created by Igor Shelopaev on 28.06.2022.
//

import SwiftUI

/// Widget demonstrating stories
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 6.0, *)
public struct StoriesWidget<M: IStoriesManager>: View {
    public typealias Item = M.Element

    // MARK: - Config

    /// Managing stories life circle
    let manager: M.Type

    /// Set of stories
    let stories: [M.Element]

    /// Start story
    let current: Item?

    /// `.once` or `.circle`
    let strategy: Strategy

    /// Delay before start stories
    let leeway: DispatchTimeInterval

    /// Shared var to control stories running process by external controls that are not inside StoriesWidget
    var pause: Binding<Bool>

    /// React on stories state change
    let onStoriesStateChanged: ((StoriesState) -> Void)?

    // MARK: - Life circle

    /// - Parameters:
    ///   - manager: Start story
    ///   - current: Start story
    ///   - strategy: `.once` or `.circle`
    ///   - leeway: Delay before start stories
    ///   - stories: Set of stories
    ///   - onStoriesStateChanged: Clouser to react on stories state change
    public init(
        manager: M.Type,
        stories: [M.Element],
        current: Item? = nil,
        strategy: Strategy = .circle,
        leeway: DispatchTimeInterval = .seconds(0),
        pause: Binding<Bool> = .constant(false),
        onStoriesStateChanged: ((StoriesState) -> Void)?
    ) {
        self.manager = manager
        self.stories = stories
        self.current = current
        self.strategy = strategy
        self.leeway = leeway
        self.pause = pause
        self.onStoriesStateChanged = onStoriesStateChanged
    }

    /// The content and behavior of the view.
    public var body: some View {
        if let error = StoriesError.validate(stories) {
            error.builder
        } else {
            StoriesView(
                manager: manager,
                stories: stories,
                current: current,
                strategy: strategy,
                leeway: leeway,
                pause: pause
            )
            .onPreferenceChange(StoriesStateKey.self) { state in
                onStoriesStateChanged?(state)
            }
        }
    }
}

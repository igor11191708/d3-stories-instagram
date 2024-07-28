//
//  IStoriesManager.swift
//
//
//  Created by Igor Shelopaev on 23.06.2022.
//

import SwiftUI

/// Interface for managing stories life circle for ``StoriesWidget``
/// Define your own manager conforming to Stories Manager if you need some specific managing processes
@available(iOS 15.0, macOS 12.0, tvOS 16.0, watchOS 10.0, *)
public protocol IStoriesManager: ObservableObject {
    associatedtype Element: IStory

    /// Time progress demonstrating the current story
    var progress: CGFloat { get set }

    /// Current stories state
    ///  Life circle: Start - ... Begin - (Suspend) - (Resume) - End ... - Finish
    var state: StoriesState { get }

    /// Check is suspended
    var suspended: Bool { get }

    /// Time buffer after suspension when Tap gesture is valid to move to the next story
    var tapTime: Bool { get }

    // MARK: - Config

    /// Set of stories
    var stories: [Element] { get }

    /// Current story
    var current: Element { get }

    /// One of the strategy defined in enum ``Strategy``
    var strategy: Strategy { get }

    /// Delay before start counting stories time
    var leeway: DispatchTimeInterval { get }

    // MARK: - API

    /// Start showing stories
    func start()

    /// Pause showing stories
    func suspend()

    /// Resume showing stories
    func resume()

    /// Next story
    func next()

    /// Previous story
    func previouse()

    /// Finish showing stories
    func finish()

    // MARK: - Life circle

    init(
        stories: [Element],
        current: Element?,
        strategy: Strategy,
        leeway: DispatchTimeInterval
    )
}

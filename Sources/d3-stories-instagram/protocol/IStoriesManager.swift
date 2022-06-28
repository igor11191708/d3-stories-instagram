//
//  IStoriesManager.swift
//
//
//  Created by Igor Shelopaev on 23.06.2022.
//

import SwiftUI


/// Interface for managing stories life circle for ``StoriesView``
/// Define your own manager conforming to Stories Manager if you need some specific managing processes
@available(iOS 15.0, macOS 12.0, watchOS 6.0, *)
public protocol IStoriesManager: ObservableObject {

    associatedtype Element: IStory

    /// Time progress demonstating the current story
    var progress: CGFloat { get set }

    /// Stories paused
    var suspended: Bool { get }
    
    /// Time buffer after suspention when Tap gesture is valid to move to the next story
    var tapTime : Bool { get }

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

    /// Pause showing stories
    func suspend()

    /// Rsume showing stories
    func resume()

    /// Start showing stories
    func begin()

    /// Finish showing stories
    func end()

    /// Next story
    func next()

    /// Previouse story
    func previouse()

    // MARK: - Life circle
    
    init(
        stories: [Element],
        current: Element?,
        strategy: Strategy,
        leeway: DispatchTimeInterval
    )
}

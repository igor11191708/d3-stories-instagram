//
//  StoriesManager.swift
//
//
//  Created by Igor Shelopaev on 23.06.2022.
//

import Combine
import SwiftUI

/// Managing logic for ``StoriesView`` component
@available(iOS 15.0, macOS 12.0, watchOS 6.0, *)
public final class StoriesManager<Item: IStory>: IStoriesManager {

    /// Time progress demonstating the current story
    @Published public var progress: CGFloat = StateManager.startProgress

    /// Stories paused
    @Published public private(set) var suspended: Bool = false

    /// State manager
    private let manager = StateManager()

    /// Subscriptions
    private var sub: AnyCancellable?
    
    @Published public var tapTime : Bool = false

    // MARK: - Config

    /// Current story
    @Published public private(set) var current: Item

    /// Set of stories
    @Published public private(set) var stories: [Item]

    /// One of the strategy defined in enum ``Strategy``
    public let strategy: Strategy

    /// Delay before start counting stories time
    public let leeway: DispatchTimeInterval

    // MARK: - Life circle
    /// Delay before start showing stories
    public init(
        stories: [Item],
        current: Item? = nil,
        strategy: Strategy = .circle,
        leeway: DispatchTimeInterval = .seconds(0)
    ) {
        self.stories = stories
        self.current = current ?? stories.first!
        self.strategy = strategy
        self.leeway = leeway

        sub = manager
            .publisher
            .sink { [weak self] in self?.onStateChanged($0) }
        
   }

    deinit { print("deinit StoriesManager") }

    // MARK: - API

    func onLongTap(){

    }
    
    /// Pause showing stories
    public func suspend() {
        if suspended { return }
        
        tapTime = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){ [weak self] in
            self?.tapTime = false
        }
        
        suspended = true
        manager.suspend()
    }

    /// Rsume showing stories
    public func resume() {
        manager.resume()
        suspended = false
    }

    /// Start showing stories
    public func begin() {
        let duration = current.duration
        DispatchQueue.main.asyncAfter(deadline: .now() + leeway) { [weak self] in
            self?.manager.begin(duration)
        }
    }

    /// Finish showing stories
    public func end() {
        manager.end()
    }

    /// Next story
    public func next() {
        current = current.next
        if validateOnce(current) { return end() }

        manager.begin(current.duration)
    }

    /// Previouse story
    public func previouse() {
        current = current.previous
        manager.begin(current.duration)
    }


    // MARK: - Private

    private func validateOnce(_ next: Item) -> Bool {
        strategy == .once && next == stories.first
    }

    /// Process state change
    /// - Parameter state: Stories showcase state
    private func onStateChanged(_ state: StoriesState) {
        switch state {
        case .next: next()
        case .suspend(let progress): return suspendAnimation(progress)
        case .resume(let progress): resumeAnimation(progress)
        case .begin: initAnimation()
        }
    }

    
    /// Typycal time slot for a story
    private func initAnimation() {
        self.progress = StateManager.startProgress
        runAnimation(1, current.duration)
    }

    private func suspendAnimation(_ progress: CGFloat) {
        runAnimation(progress, 0)
    }

    private func resumeAnimation(_ progress: CGFloat) {
        let duration = (1 - progress) * current.duration
        runAnimation(1, duration)
    }
    
    /// Customed animation for progress
    /// - Parameters:
    ///   - progress: Endpoint progress
    ///   - duration: Time
    private func runAnimation(_ progress: CGFloat, _ duration: Double) {
        withAnimation(.linear(duration: duration)) {
            self.progress = progress
        }
    }

}


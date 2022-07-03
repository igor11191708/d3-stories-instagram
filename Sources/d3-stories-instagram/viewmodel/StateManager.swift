//
//  StateManager.swift
//
//
//  Created by Igor Shelopaev on 27.06.2022.
//

import Combine
import SwiftUI

/// Managing stories life circle
final class StateManager {

    /// Sorry:) 0.00001 - fixing bug with animation in SwiftUI
    static let startProgress = 0.00001

    /// Publisher for posting states ``StoriesState``
    let publisher = PassthroughSubject<StoriesState, Never>()
    
    private var timerSubscription: AnyCancellable?

    /// Current progress
    private var progress: CGFloat = StateManager.startProgress

    /// When story started
    private var startTime: Date?

    /// Story duration
    private var duration: TimeInterval = 0
    
    // MARK: - Life circle
    
    deinit { end(); print("deinit StateManager") }
    
    // MARK: - Private

    /// Schedule and start timer
    private func schedule(_ duration: TimeInterval) {

        updateStartTime()

        timerSubscription = Timer.publish(every: duration, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
            self?.timerSubscription = nil
            self?.publishNext()
        }
    }

    private func publishNext() {
        publisher.send(.end)
    }

    private func updateStartTime() {
        let passed = progress * duration
        startTime = Date() - TimeInterval(passed)
    }

    // MARK: - API
    
    /// Pause showing stories
    public func suspend() {
        let now = Date()
        let hasPassed = now.timeIntervalSince(startTime ?? now)
        progress = hasPassed / duration
        timerSubscription = nil

        publisher.send(.suspend(progress))
    }

    /// Rsume showing stories
    public func resume() {
        let left = duration - (progress * duration)

        schedule(left)
        publisher.send(.resume(progress))
    }
    
    /// Start big stories circle
    /// - Parameters:
    ///   - duration: Duration for the first story
    ///   - leeway: Delay befire start
    public func start(_ duration: TimeInterval, leeway : DispatchTimeInterval){
        publisher.send(.start)
        DispatchQueue.main.asyncAfter(deadline: .now() + leeway) { [weak self] in
            self?.begin(duration)
        }
    }
    
    /// Start showing story
    public func begin(_ duration: TimeInterval) {
        self.duration = duration
        self.progress = StateManager.startProgress

        schedule(duration)
        publisher.send(.begin)
    }

    /// Finish showing stories
    public func end() {
        publisher.send(.finish)
        timerSubscription = nil
    }

}

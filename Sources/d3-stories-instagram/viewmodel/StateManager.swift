//
//  StateManager.swift
//
//
//  Created by Igor Shelopaev on 27.06.2022.
//

import Combine
import SwiftUI

final class StateManager {

    /// Sorry:) 0.00001 - fixing bug with animation in SwiftUI
    static let startProgress = 0.00001

    /// Publisher for posting states ``StoriesState``
    let publisher = PassthroughSubject<StoriesState, Never>()

    private var timerSubscription: AnyCancellable?

    var progress: CGFloat = StateManager.startProgress

    var startTime: Date?

    var duration: TimeInterval = 0

    deinit { print("deinit StateManager") }

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
        publisher.send(.next)
    }

    private func updateStartTime() {
        let passed = progress * duration
        startTime = Date() - TimeInterval(passed)
    }

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

    /// Start showing stories
    public func begin(_ duration: TimeInterval) {
        self.duration = duration
        self.progress = StateManager.startProgress

        schedule(duration)
        publisher.send(.begin)
    }

    /// Finish showing stories
    public func end() {
        timerSubscription = nil
    }

}

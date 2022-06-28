//
//  StoriesView.swift
//
//
//  Created by Igor Shelopaev on 23.06.2022.
//

import SwiftUI

/// Component demonstrating stories
struct StoriesView<M : IStoriesManager>: View {

    typealias Item = M.Element

    /// Detecting color scheme
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    /// Managing stories life circle for ``StoriesView`` component
    @StateObject private var model: M

    // MARK: - Life circle

    /// - Parameters:
    ///   - manager: Start story
    ///   - current: Start story
    ///   - strategy: `.once` or `.circle`
    ///   - leeway: Delay before start stories
    ///   - stories: Set of stories
    init(
        manager: M.Type,
        stories: [M.Element],
        current: Item? = nil,
        strategy: Strategy = .circle,
        leeway: DispatchTimeInterval = .seconds(0)
    ) {

        _model = StateObject(wrappedValue:
                manager.init(stories: stories, current: current, strategy: strategy, leeway: leeway)
        )
    }

    /// The content and behavior of the view.
    var body: some View {
        GeometryReader { proxy in
            let h = proxy.size.height / 25
            bodyTpl
                .overlay(directionControl)

            progressView
                .padding(.top, h)
        }
            .environment(\.colorScheme, model.current.colorScheme ?? colorScheme)
            .onAppear(perform: model.begin)
            .onDisappear(perform: model.end)
    }

    // MARK: - Private

    ///Managing suspend and resume states
    private var gesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
            if !model.suspended {
                model.suspend()
            }
        }
            .onEnded { _ in model.resume() }
    }

    /// Cover controls for step forward and backward and pause
    /// from width: 25% cover - step backward, 75% - step forward
    /// Long press on 75% - to pause
    @ViewBuilder
    private var directionControl: some View {
        GeometryReader { proxy in
            let w = proxy.size.width
            Color.white.opacity(0.001)
                .onTapGesture() {
                if model.tapTime {
                    model.next()
                }
            }
                .simultaneousGesture(gesture)
            Color.white.opacity(0.001)
                .frame(width: w * 0.25)
                .onTapGesture() {
                model.previouse()
            }
                .simultaneousGesture(gesture)
        }
    }

    /// Body template for curent story defined in ``IStory`` property ```builder```
    @ViewBuilder
    private var bodyTpl: some View {
        model.current.builder(progress: $model.progress)
    }

    /// Progress bar builder
    @ViewBuilder
    private var progressView: some View {
        ProgressBar(
            stories: model.stories,
            current: model.current,
            progress: model.progress
        ).padding(.horizontal)
    }
}

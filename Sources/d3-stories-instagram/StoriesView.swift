//
//  StoriesView.swift
//
//
//  Created by Igor Shelopaev on 23.06.2022.
//

import SwiftUI

/// Component demonstrating stories
struct StoriesView<M: IStoriesManager>: View {
    typealias Item = M.Element

    /// Detecting color scheme
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    /// Managing stories life circle for ``StoriesView`` component
    @StateObject private var model: M

    /// Shared var to control stories running process by external controls that are not inside StoriesWidget
    private var pause: Binding<Bool>
    
    /// ProgressBar configuration
    private let progressBarConfig: ProgressBarConfig

    // MARK: - Life circle

    /// - Parameters:
    ///   - manager: Start story
    ///   - current: Start story
    ///   - strategy: `.once` or `.circle`
    ///   - leeway: Delay before start stories
    ///   - stories: Set of stories
    ///   - progressBarConfig: progressBar configuration: height, spacing, active & inactive colors
    init(
        manager: M.Type,
        stories: [Item],
        current: Item? = nil,
        strategy: Strategy = .circle,
        leeway: DispatchTimeInterval = .seconds(0),
        pause: Binding<Bool>,
        progressBarConfig: ProgressBarConfig = .init()
    ) {
        self.pause = pause
        self.progressBarConfig = progressBarConfig

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
        .onAppear(perform: model.start)
        .onDisappear(perform: model.finish)
        .onChange(of: pause.wrappedValue, perform: onPause)
        .preference(key: StoriesStateKey.self, value: model.state)
    }

    // MARK: - Private

    /// Process pause, resume actions Check suspended as action can come from Gesture or external source to pause or resume stories run
    /// - Parameter value: true - pause, false - resume
    private func onPause(value: Bool) {
        if value {
            if !model.suspended {
                model.suspend()
            }
        } else {
            if model.suspended {
                model.resume()
            }
        }
    }

    /// Managing suspend and resume states
    private var gesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
                if !model.suspended {
                    pause.wrappedValue = true
                    model.suspend()
                }
            }
            .onEnded { _ in
                pause.wrappedValue = false
                model.resume()
            }
    }

    /// Cover controls for step forward and backward and pause
    /// from width: 25% cover - step backward, 75% - step forward
    /// Long press on 75% - to pause
    @ViewBuilder
    private var directionControl: some View {
        GeometryReader { proxy in
            let w = proxy.size.width
            Color.white.opacity(0.001)
                .onTapGesture {
                    if model.tapTime {
                        model.next()
                    }
                }
                .simultaneousGesture(gesture)
            Color.white.opacity(0.001)
                .frame(width: w * 0.25)
                .onTapGesture {
                    model.previouse()
                }
                .simultaneousGesture(gesture)
        }
    }

    /// Body template for current story defined in ``IStory`` property ```builder```
    @ViewBuilder
    private var bodyTpl: some View {
        model.current.builder(progress: $model.progress)
    }

    /// Progress bar builder
    @ViewBuilder
    private var progressView: some View {
        ProgressBar(
            config: progressBarConfig, 
            stories: model.stories,
            current: model.current,
            progress: model.progress
        ).padding(.horizontal)
    }
}

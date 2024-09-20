//
//  ProgressBar.swift
//
//
//  Created by Igor Shelopaev on 23.06.2022.
//

import SwiftUI

/// Indicate time progress for ``StoriesView`` component
struct ProgressBar<Item: IStory>: View {
    /// ProgressBar configuration: height, spacing, active & inactive colors
    let config: ProgressBarConfig

    // MARK: - Config

    /// Set of data
    let stories: [Item]

    /// Current item from data set
    let current: Item

    /// Progress of showing current item
    let progress: CGFloat

    // MARK: - Life circle

    var body: some View {
        HStack(spacing: config.spacing) {
            ForEach(stories, id: \.self) { story in
                GeometryReader { proxy in
                    let width = proxy.size.width
                    itemTpl(story, width)
                }
            }
        }.frame(height: config.height)
    }

    // MARK: - private

    /// Progress slot view
    @ViewBuilder
    private func itemTpl(_ item: Item, _ width: CGFloat) -> some View {
        config.inactiveColor
            .overlay(progressTpl(item, width, current), alignment: .leading)
            .clipShape(Capsule())
    }

    /// Progress slot overlay view
    /// - Parameters:
    ///   - item: Story
    ///   - width: Available space
    ///   - current: Current story
    /// - Returns: View
    @ViewBuilder
    private func progressTpl(_ item: Item, _ width: CGFloat, _ current: Item) -> some View {
        if item.isBefore(current) { // has already passed
            config.activeColor
        } else if item == current {
            config.activeColor.frame(width: progress * width) // current progress
        } else {
            EmptyView()
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView(manager: StoriesManager.self, stories: Stories.allCases, pause: .constant(false))
            .preferredColorScheme(.dark)
    }
}

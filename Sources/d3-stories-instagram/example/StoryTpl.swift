//
//  StoryTpl.swift
//
//
//  Created by Igor Shelopaev on 28.06.2022.
//

import SwiftUI


struct StoryTpl<T : IStory>: IStoryTpl {

    /// Detecting color scheme
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    // MARK: - Config

    let color: Color

    let text: String

    @Binding var progress: CGFloat

    let story: T

    // MARK: - Life circle

    init(_ story: T, _ color: Color, _ text: String, _ progress: Binding<CGFloat>) {
        self.story = story
        self.color = color
        self.text = text
        self._progress = progress
    }

    var body: some View {
        color
            .ignoresSafeArea()
            .overlay(textBuilder)
    }

    // MARK: - Private
    
    @ViewBuilder
    private func textBuilder(_ text: String, size: CGFloat = 350) -> some View {
        VStack {
            Text(text).font(.system(size: size, weight: .bold, design: .rounded))
        }
    }
    
    @ViewBuilder
    private var textTpl: some View {
        let d = 180 - (180 * progress)
        VStack {
            textBuilder(text)
                .scaleEffect(progress)
                .rotation3DEffect(.degrees(d), axis: (x: 0, y: 1, z: 0))
                .opacity(progress)

            textBuilder("story", size: 50)
        }.environment(\.colorScheme, story.colorScheme ?? colorScheme)
    }
    
    @ViewBuilder
    private var textBuilder: some View {
        #if os(iOS)
            textTpl
        #else
            textTpl.drawingGroup()
        #endif
    }


}

struct StoryTpl_Previews: PreviewProvider {
    static var previews: some View {
        StoryTpl(Stories.first, .yellow, "Story", .constant(0.1))
    }
}



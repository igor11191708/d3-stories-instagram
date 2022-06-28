//
//  Stories.swift
//
//
//  Created by Igor Shelopaev on 23.06.2022.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, watchOS 6.0, *)
public enum Stories: IStory {
      
    case first
    case second
    case third
    case fourth
    case fifth

    @ViewBuilder
    /// Define view template for every story
    public func builder(progress : Binding<CGFloat>) -> some View {
        switch(self) {
        case .first: StoryTpl(self, .green, "1", progress)
        case .second: StoryTpl(self, .brown, "2", progress)
        case .third: StoryTpl(self, .purple, "3", progress)
        case .fourth: StoryTpl(self, .yellow, "4", progress)
        case .fifth: StoryTpl(self, .orange, "5", progress)
        }
    }
    
    
    /// Define every story duration or just one as a default for everyone
    public var duration: TimeInterval {
        switch self{
        case .first, .third : return 4
        default : return 3
        }
    }

    /// Optianl param to define color scheme for some stories
    /// Sometimes one story demands light scheme the other demands dark becouse of story's design
    public var colorScheme: ColorScheme? {
        switch(self) {
        case .first: return .light
        case .fourth: return .light
        default: return .dark
        }
    }

}

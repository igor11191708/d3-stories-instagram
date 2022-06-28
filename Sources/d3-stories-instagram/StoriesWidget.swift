//
//  StoriesWidget.swift
//
//
//  Created by Igor Shelopaev on 28.06.2022.
//

import SwiftUI

/// Widget demonstrating stories
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 6.0, *)
public struct StoriesWidget<M : IStoriesManager>: View {

    public typealias Item = M.Element

    // MARK: - Config
    
    /// Managing stories life circle
    let manager: M.Type
    
    /// Set of stories
    let stories: [M.Element]
    
    /// Start story
    let current: Item?
    
    ///`.once` or `.circle`
    let strategy: Strategy
    
    ///Delay before start stories
    let leeway: DispatchTimeInterval

    // MARK: - Life circle
    
    /// - Parameters:
    ///   - current: Start story
    ///   - strategy: `.once` or `.circle`
    ///   - leeway: Delay before start stories
    ///   - stories: Set of stories
    public init(
        manager: M.Type,
        stories: [M.Element],
        current: Item? = nil,
        strategy: Strategy = .circle,
        leeway: DispatchTimeInterval = .seconds(0)
    ) {
       
        self.manager = manager
        self.stories = stories
        self.current = current
        self.strategy = strategy
        self.leeway = leeway
    }
    
    public var body: some View {
        if stories.isEmpty{
            Text("No stories")
        }else{
            StoriesView(
                manager: manager,
                stories: stories,
                current: current,
                strategy: strategy,
                leeway: leeway
            )
        }
    }
}


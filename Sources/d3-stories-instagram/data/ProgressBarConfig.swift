//
//  ProgressBarConfig.swift
//
//
//  Created by Isaac Iniongun on 01/03/2024.
//

import SwiftUI

public struct ProgressBarConfig {
    let height: CGFloat
    let spacing: CGFloat
    let activeColor: Color
    let inactiveColor: Color
    
    public init(
        height: CGFloat = 2,
        spacing: CGFloat = 5,
        activeColor: Color = .primary,
        inactiveColor: Color = .primary.opacity(0.5)
    ) {
        self.height = height
        self.spacing = spacing
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }
}

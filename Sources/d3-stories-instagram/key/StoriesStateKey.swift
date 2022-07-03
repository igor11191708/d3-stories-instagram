//
//  StoriesStateKey.swift
//  
//
//  Created by Igor Shelopaev on 03.07.2022.
//

import SwiftUI


/// Emerging stories state for ``StoriesWidget``
struct StoriesStateKey : PreferenceKey{
    
    typealias Value = StoriesState
    
    static var defaultValue: StoriesState = .ready
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
    
}

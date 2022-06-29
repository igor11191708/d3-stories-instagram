# SwiftUI and Combine - Stories instagram widget

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FThe-Igor%2Fd3-stories-instagram%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/The-Igor/d3-stories-instagram)

 ## Features
- [x] Long tap - pause stories showcase
- [x] Tap - next story
- [x] Leeway - pause before start stories
- [x] Customize component with you own stories and every story with it's own view
- [x] Customize time longevity for every story
- [x] iOS and macOS support
- [x] Customizable **dark** and **light** scheme support for every story
- [x] Control stories run as by external controls that are not inside StoriesWidget so via Gesture

## 1. Stories
Define enum with your stories conforming to **IStory**

```swift
    public enum Stories: IStory {
          
        case first
        case second
        case third

        @ViewBuilder
        public func builder(progress : Binding<CGFloat>) -> some View {
            switch(self) {
                case .first:  StoryTpl(self, .green,  "1", progress)
                case .second: StoryTpl(self, .brown,  "2", progress)
                case .third:  StoryTpl(self, .purple, "3", progress)
            }
        }
        
        public var duration: TimeInterval {
            switch self{
                case .first, .third : return 5
                default : return 3
            }
        }

        public var colorScheme: ColorScheme? {
            switch(self) {
                case .first: return .light
                default: return .dark
            }
        }

    }
```

## 2. Create stories widget

* `manager` - package standard manager **StoriesManager.self** for managing stories life circle. <br/>*Define your own manager conforming to **IStoriesManager** if you need some specific managing processe*
* `stories` - stories conforming to **IStory**

```Swift 
    StoriesWidget(
        manager: StoriesManager.self,
        stories: Stories.allCases
    )
```

### Optional

* `strategy` - default strategy is **circle**

| Strategy | Description |
| --- | --- |
|**circle**| Repeat stories |
|**once**| Show just once |


* `current` - start story if not defined start with first

* `leeway` - delay before start stories, default **.seconds(0)**

* `pause` - shared var to control stories running process by external controls that are not inside StoriesWidget, default **.constant(false)**. For example if you launched modal view and need to pause running stories while modal view is existed you can do it via shared variable passing as a binding in StoriesWidget.


## SwiftUI example of using package
[d3-stories-instagram-example](https://github.com/The-Igor/d3-stories-instagram-example)

[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-stories-instagram/blob/main/img/img_01.gif)](https://youtu.be/GW01UyqzaeE)

[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-stories-instagram/blob/main/img/img_08.gif)](https://youtu.be/GW01UyqzaeE)

[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-stories-instagram/blob/main/img/img_03.png)](https://youtu.be/GW01UyqzaeE)

## Documentation(API)
- You need to have Xcode 13 installed in order to have access to Documentation Compiler (DocC)
- Go to Product > Build Documentation or **⌃⇧⌘ D**

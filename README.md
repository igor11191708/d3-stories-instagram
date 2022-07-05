# SwiftUI and Combine - Stories intro multiplatform widget

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FThe-Igor%2Fd3-stories-instagram%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/The-Igor/d3-stories-instagram)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FThe-Igor%2Fd3-stories-instagram%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/The-Igor/d3-stories-instagram)

 ## Features
- [x] Long tap - pause stories showcase
- [x] Tap - next story
- [x] Leeway - pause before start stories
- [x] Customize component with you own stories and every story with it's own view
- [x] Customize time longevity for every story
- [x] iOS and macOS support
- [x] Customizable **dark** and **light** scheme support for every story
- [x] Control stories run as by external sources that are not inside StoriesWidget so via Gesture
- [x] Observing stories life circle for reacting on state change
- [x] Internal and custom external errors handling
- [x] Localization (En, Es) All errors and system messages are localized.

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

* `manager` - package standard manager **StoriesManager.self** for managing stories life circle. <br/>*Define your own manager conforming to **IStoriesManager** if you need some specific managing process*
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

* `pause` - shared var to control stories run by external sources that are not inside StoriesWidget, default **.constant(false)**. For example if you launched modal view and need to pause running stories while modal view is existed you can do it via shared variable passing as a binding in StoriesWidget.
* `validator` - Custom validator to check validity of stories data set before start
* `onStoriesStateChanged` - Closure to react on stories state change


## Stories life circle
You can observe events of the stories life circle and react on it's change. Pass closure to config of **StoriesWidget**.<br>
- **onStoriesStateChanged(**StoriesState**)** - Closure to react on stories state change

``` swift
    StoriesWidget(
        manager: StoriesManager.self,
        stories: Stories.allCases                    
    ){ state in
        print("Do something on stories \(state) change")
    }
```

| State | Description |
| --- | --- |
|**ready**| Waiting to start If there's leeway this is the state during this delay before the big start |
|**start**| Big start |
|**begin**| Begin of a story |
|**end**| End of a story |
|**suspend**| At the moment of pause and then is kept until is resumed. Informs that currently demostration is paused |
|**resume**| At the moment of resume and then is kept until the next pause or end of a story |
|**finish**| Big finish. At the end of the stratagy **.once** |

![Stories life circle](https://github.com/The-Igor/d3-stories-instagram/blob/main/img/stories_state.png)

## Stories error handling
There's internal check of stories data
- There are no stories
- Duration must be a positive number greater than zero

### Custom stories error handling

if you need custom check for stories data, just implement validator conforming to **IStoriesValidater** and pass it as a parameter to **StoriesWidget**

```Swift 
    StoriesWidget(
        manager: StoriesManager.self,
        stories: Stories.allCases,
        validator: CustomStoriesValidater.self
    )
```
There's an example of custom validator. Take a look on
[**CustomStoriesValidater**](https://github.com/The-Igor/d3-stories-instagram/blob/main/Sources/d3-stories-instagram/example/CustomStoriesValidater.swift)  implementation. Stories won't be started if there's an error then instead of stories there'll be the error view with description of errors. 

![Custom error handling for stories](https://github.com/The-Igor/d3-stories-instagram/blob/main/img/errors_handling.png)

## Localization (En, Es)
All the internal errors and system messages that might occur are localized. Localization for stories is up to you as it's external source for the component.

*Se localizan todos los errores internos y mensajes del sistema que puedan producirse. La localización de las historias depende de usted, ya que es la fuente externa del componente.*

![Custom stories error handling](https://github.com/The-Igor/d3-stories-instagram/blob/main/img/localization.png)


## SwiftUI example of using package
[d3-stories-instagram-example](https://github.com/The-Igor/d3-stories-instagram-example)

[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-stories-instagram/blob/main/img/img_01.gif)](https://youtu.be/GW01UyqzaeE)

[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-stories-instagram/blob/main/img/img_08.gif)](https://youtu.be/GW01UyqzaeE)

[![click to watch expected UI behavior for the example](https://github.com/The-Igor/d3-stories-instagram/blob/main/img/img_03.png)](https://youtu.be/GW01UyqzaeE)

## Documentation(API)
- You need to have Xcode 13 installed in order to have access to Documentation Compiler (DocC)
- Go to Product > Build Documentation or **⌃⇧⌘ D**

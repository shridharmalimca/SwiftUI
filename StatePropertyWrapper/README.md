## SwiftUI

 - **@State**:
        A property wrapper type that can read and write a value managed by the SwiftUI.
        SwiftUI manages the storage of a property that you can declare as state. When the value changes, SwiftUI updates the parts of the view hierarchy that depends on the value. Use state as single source of truth for the given value stored in a view hierarchy.
        `State` instance is not a value itself. it's a mean of reading and writting the value. To access a state's underlying value we have use the property name which returns ``State\wrappedValue`` property value.
        Passing state value to child view - If you pass state property to child view, SwiftUI updates the child any time the value changes in the parent but child can't modify the value.
        To enable the child view to modify the stored value pass a `Binding`. We can cover this in next topic.
        
    [](https://github.com/shridharmalimca/SwiftUI/blob/main/StatePropertyWrapper/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20-%202022-12-22%20at%2012.10.10.png)
    
    [](/Users/macbook/Documents/Git_Repos/SwiftUI/StatePropertyWrapper/Simulator Screen Shot - iPhone 14 Pro - 2022-12-22 at 12.10.13.png)

- **@Binding**:


 


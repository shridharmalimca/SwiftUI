## SwiftUI

 - **@State**:
        A property wrapper type that can read and write a value managed by the SwiftUI.
        SwiftUI manages the storage of a property that you can declare as state. When the value changes, SwiftUI updates the parts of the view hierarchy that depends on the value. Use state as single source of truth for the given value stored in a view hierarchy.
        `State` instance is not a value itself. it's a mean of reading and writting the value. To access a state's underlying value we have use the property name which returns ``State\wrappedValue`` property value.
        Passing state value to child view - If you pass state property to child view, SwiftUI updates the child any time the value changes in the parent but child can't modify the value.
        To enable the child view to modify the stored value pass a `Binding`. We can cover this in next topic.
        
    [Initial Value](initialValue.png)
    
    [After changes](afterChange.png)
    
- **@Binding**:


 


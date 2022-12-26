//
//  ContentView.swift
//  ViewBuilder
//
//  Created by Macbook on 26/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        
            DLButton("Button") {
                
            } action: {
                print("Clicked")
            }
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DefaultViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.blue)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.orange)
            .cornerRadius(10)
    }
}

struct ChevronViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.black)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .cornerRadius(10)
    }
}

extension View {
    func withDefaultModifier() -> some View {
        modifier(DefaultViewModifier())
    }
    
    func chevronButton() -> some View {
        modifier(ChevronViewModifier())
    }
    
    func defaultButton() -> some View {
        modifier(DefaultButtonModifier())
    }
}

extension View {
    func type() -> some View {
        print(Swift.type(of: self))
        return self
    }
}

struct DLButton<Content:View> :View {
    
    let content: Content
    let title: String
    let action: () -> Void
    
    init(_ title: String, @ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void) {
        self.title = title
        self.content = content()
        self.action = action
    }
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Text(title)
            }
            .defaultButton()
        }
    }
}

struct DefaultButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.black)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .cornerRadius(10)
    }
}

struct Passthrough<Content: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack(content: content)
        } else {
            HStack(content: content)
        }
    }
}

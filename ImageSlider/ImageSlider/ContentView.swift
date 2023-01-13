//
//  ContentView.swift
//  ImageSlider
//
//  Created by Macbook on 10/01/23.
//

import SwiftUI

struct ContentView: View {
    
    let images = ["1", "2", "3", "4", "5"]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(alignment:.top, spacing: 0) {
                    DLImageSlider(images) {
                        
                    }
                    Image("oxetol")
                        .resizable()
                }
                .frame(maxHeight: 350)
                HStack {
                    VStack {
                        Text("Offers established efficacy and favourable tolerability in various neuropathic pain conditions")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.blue)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.red)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.green)
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.yellow)
                            Spacer()
                        }
                    }
                }
                
            // reference view
                ReferenceView(upperText: "Dummy Text", middleText: ["First Text", "Second text"], isShowAvailableButton: true, navigationButtonImage: "available")
                
            }.padding()
                .toolbar {
                    ToolbarItem {
                        Button {
                            
                        } label: {
                            Image(systemName: "text.justify").onTapGesture {
                                print("Clicked")
                            }
                        }
                    }
                }
        }
    }
}

struct DLImageSlider<Content: View> : View {
    
    let content: Content
    let images: [String]
    
    @State private var index = 0
    public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    init(_ images: [String], @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.images = images
    }
    
    var body: some View {
        TabView(selection: $index) {
            ForEach(0..<images.count, id: \.self) { i in
                Image("\(images[i])")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onReceive(timer, perform: { _ in
            
            withAnimation{
                print("selection is",index)
                index = index < images.count ? index + 1 : 0
            }
        })
    }
}

struct PageControl: View {
    @State var index: Int
    let maxIndex: Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0...maxIndex, id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.white : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

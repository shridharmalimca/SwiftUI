//
//  DLImageView.swift
//  ImageSlider
//
//  Created by Macbook on 10/01/23.
//

import SwiftUI

struct DLImageView<Content: View>: View {
    
    let image: String
    let content: Content
    let action: () -> Void
    
    init(imageName: String, @ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void) {
        self.image = imageName
        self.content = content()
        self.action = action
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack {
                Text("Hacking with Swift")
                        .font(.largeTitle)
                        .background(.black)
                        .foregroundColor(.red)
                Image(image)
                    .resizable()
            }
        }
        .padding()
        .background(.clear)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 3)
                .onTapGesture {
                    action()
                }
        }
    }
}



struct DLImageView_Previews: PreviewProvider {
    static var previews: some View {
        DLImageView(imageName: "1") {
            
        } action: {
            
        }

    }
}

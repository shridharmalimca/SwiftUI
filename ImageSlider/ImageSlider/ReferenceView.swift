//
//  ReferenceView.swift
//  ImageSlider
//
//  Created by Macbook on 10/01/23.
//

import SwiftUI

struct ReferenceView: View {
    @State var upperText: String
    @State var middleText: [String]
    @State var isShowAvailableButton = false
    @State var navigationButtonImage = ""
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(upperText)
            }
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("REF")
                        .font(.title)
                        .frame(width: 55, height: 55)
                        .padding()
                })
                .background(Color.yellow)
                .cornerRadius(8.0)
                VStack(alignment: .leading) {
                    ForEach(middleText, id: \.self) { text in
                        Text(text)
                            .foregroundColor(.black)
                    }
                }
                .background(RoundedRectangle(cornerRadius: 0.0).foregroundColor(.yellow))
                .padding()
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(navigationButtonImage)
                        .resizable()
                })
                .frame(width: 250, height: 100)
                .background(Color.yellow)
                .cornerRadius(8.0)
            }
        }
    }
}

struct ReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceView(upperText: "Dummy Text", middleText: ["First Text", "Second text"], isShowAvailableButton: true, navigationButtonImage: "available")
    }
}

//
//  PostDetailsView.swift
//  EnvironmentObject
//
//  Created by Macbook on 31/12/22.
//

import SwiftUI

struct PostDetailsView: View {
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("Click")
                    Spacer()
                    NavigationLink("", destination: PostDetailForEnvironmentObjectTest())
                }
            }
            .navigationTitle("Details")
        }
    }
}

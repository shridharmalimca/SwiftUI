//
//  PostDetailForEnvironmentObjectTest.swift
//  EnvironmentObject
//
//  Created by Macbook on 31/12/22.
//

import SwiftUI

struct PostDetailForEnvironmentObjectTest: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(viewModel.posts[0].body)
                    .font(.title3)
            }
            .navigationTitle("Env Object Test")
        }
    }
}


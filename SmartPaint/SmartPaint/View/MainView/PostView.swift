//
//  PostView.swift
//  SmartPaint
//
//  Created by jackychoi on 5/1/2024.
//

import SwiftUI

struct PostView: View {
    @State private var recentsPost: [Post] = []
    @State private var createNewPost: Bool = false
    var body: some View {
        NavigationStack{
            ReusablePostsView(posts: $recentsPost)
                .hAlign(.center).vAlign(.center)
                .overlay(alignment: .bottomTrailing) {
                    Button(action: {
                        createNewPost.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(13)
                            .background(.black,in:Circle())
                    })
                    .padding(15)
                }
                .navigationTitle("Post's")
        }
        .fullScreenCover(isPresented: $createNewPost){
            CreateNewPost{
                post in
                
            }
        }
    }
}

#Preview {
    PostView()
}

//
//  PeusablePostsView.swift
//  SmartPaint
//
//  Created by jackychoi on 5/1/2024.
//

import SwiftUI
import Firebase

struct ReusablePostsView: View {
    @Binding var posts: [Post]
    
    @State var isFetching: Bool = false
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVStack{
                if isFetching{
                    ProgressView()
                        .padding(.top,30)
                }else{
                    if posts.isEmpty{
                        Text("No Post's Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top,30)
                    }else{
                        Posts()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func Posts()->some View{
        ForEach(posts){
            post in
            Text(post.text)
        }
    }
    
    func fetchPosts() async{
        do{
            var query: Query!
            query = Firestore.firestore().collection("Posts")
                .order(by: "publishedDate",descending: true)
                .limit(to: 20)
            let docs = try await query.getDocuments()
        }catch{
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}

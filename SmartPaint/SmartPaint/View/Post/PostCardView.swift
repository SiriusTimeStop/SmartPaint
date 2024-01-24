//
//  PostCardView.swift
//  SmartPaint
//
//  Created by jackychoi on 5/1/2024.
//MARK: Source Code follow to youtube "SwiftUI Social Media App - Firebase" https://www.youtube.com/watch?v=-pAQcPolruw&t=1279s

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct PostCardView: View {
    var post: Post
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()
    //MARK: view properties
    @AppStorage("user_UID") private var userUID: String = ""
    @State private var docListner: ListenerRegistration?
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            verticalLayout
        } else {
            horizontalLayout
        }
    }
    
    @ViewBuilder
    private var verticalLayout: some View{
        HStack(alignment: .top, spacing: 12){
            WebImage(url: post.userProfileURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 35, height: 35)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 6){
                Text(post.userName)
                    .font(.callout)
                    .fontWeight(.semibold)
                Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text(post.text)
                    .textSelection(.enabled)
                    .padding(.vertical,8)
                
                //MARK: post image
                if let postImageURL = post.imageURL{
                    GeometryReader{
                        let size = $0.size
                        WebImage(url: postImageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .frame(height: 200)
                }
                
                PostInterestion()
            }
        }
        .hAlign(.leading)
        .overlay(alignment: .topTrailing, content: {
            //MARK: display delete button
            if post.userID == userUID{
                Menu{
                    Button("Delete Post",role:.destructive,action: deletePost)
                }label: {
                    Image(systemName: "ellipsis")
                        .font(.caption)
                        .rotationEffect(.init(degrees: -90))
                        .foregroundColor(.black)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .offset(x:8)
            }
        })
        .onAppear{
            if docListner == nil{
                guard let postID = post.id else{return}
                docListner = Firestore.firestore().collection("Posts").document(postID).addSnapshotListener({
                    snapshot, error in
                    if let snapshot{
                        if snapshot.exists{
                            if let updatedPost = try? snapshot.data(as: Post.self){
                                onUpdate(updatedPost)
                            }
                        }else{
                            onDelete()
                        }
                    }
                })
            }
        }
        .onDisappear{
            if let docListner{
                docListner.remove()
                self.docListner = nil
            }
        }
    }
    
    private var horizontalLayout: some View{
        HStack(alignment: .center, spacing: 12){
            VStack(alignment:.center,spacing: 10){
                WebImage(url: post.userProfileURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 105, height: 105)
                    .clipShape(Circle())
                
                VStack(alignment: .center, spacing: 6){
                    Text(post.userName)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                        .font(.callout)
                        .foregroundColor(.gray)
                    Text(post.text)
                        .textSelection(.enabled)
                        .font(.title3)
                    
                    PostInterestion()
                }
            }
            VStack(alignment:.center){
                
                //MARK: post image
                if let postImageURL = post.imageURL{
                    GeometryReader{
                        let size = $0.size
                        WebImage(url: postImageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .frame(height: 250)
                    .padding(.horizontal,50)
                }
            }
        }
        .hAlign(.leading)
        .overlay(alignment: .topTrailing, content: {
            //MARK: display delete button
            if post.userID == userUID{
                Menu{
                    Button("Delete Post",role:.destructive,action: deletePost)
                }label: {
                    Image(systemName: "ellipsis")
                        .font(.caption)
                        .rotationEffect(.init(degrees: -90))
                        .foregroundColor(.black)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .offset(x:8)
            }
        })
        .onAppear{
            if docListner == nil{
                guard let postID = post.id else{return}
                docListner = Firestore.firestore().collection("Posts").document(postID).addSnapshotListener({
                    snapshot, error in
                    if let snapshot{
                        if snapshot.exists{
                            if let updatedPost = try? snapshot.data(as: Post.self){
                                onUpdate(updatedPost)
                            }
                        }else{
                            onDelete()
                        }
                    }
                })
            }
        }
        .onDisappear{
            if let docListner{
                docListner.remove()
                self.docListner = nil
            }
        }
    }
    
    //MARK: like/dislike
    @ViewBuilder
    func PostInterestion() -> some View{
        HStack(spacing:6){
            Button {
                likePost()
            } label: {
                Image(systemName: post.likedIDs.contains(userUID) ? "hand.thumbsup.fill" : "hand.thumbsup")
            }
            
            Text("\(post.likedIDs.count)")
                .font(.caption)
                .foregroundColor(.gray)

            Button {
                dislikePost()
            } label: {
                Image(systemName: post.dislikedIDs.contains(userUID) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
            }
            .padding(.leading,25)
            
            Text("\(post.dislikedIDs.count)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .foregroundColor(.black)
        .padding(.vertical,8)
    }
    
    //MARK: like post
    func likePost(){
        Task{
            guard let postID = post.id else{return}
            if post.likedIDs.contains(userUID){
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs": FieldValue.arrayRemove([userUID])
                ])
            }else{
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs": FieldValue.arrayUnion([userUID]),
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
            }
        }
    }
    
    //MARK: Dislike post
    func dislikePost(){
        Task{
            guard let postID = post.id else{return}
            if post.dislikedIDs.contains(userUID){
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
            }else{
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs": FieldValue.arrayRemove([userUID]),
                    "dislikedIDs": FieldValue.arrayUnion([userUID])
                ])
            }
        }
    }
    
    //MARK: delete post
    func deletePost(){
        Task{
            
            do{
                if post.imageReferenceID != ""{
                    try await Storage.storage().reference().child("Post_Images").child(post.imageReferenceID).delete()
                }
                
                guard let postID = post.id else{return}
                try await Firestore.firestore().collection("Posts").document(postID).delete()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

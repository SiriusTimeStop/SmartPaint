//
//  CreateNewPost.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//MARK: Source Code refer to youtube "SwiftUI Social Media App - Firebase" https://www.youtube.com/watch?v=-pAQcPolruw&t=1279s

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

struct CreateNewPost: View {
    
    var onPost: (Post) -> ()
    @State private var postText: String = ""
    @State private var postImageData: Data?
    //MARK: - Stored user
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""
    //MARK: - view properties
    @Environment(\.dismiss) private var dismiss
    @State private var isloading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var photoItem: PhotosPickerItem?
    @FocusState private var showKeyboard: Bool
    
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
        
        VStack{
            HStack{
                Menu{
                    Button("Cancel",role: .destructive){
                        dismiss()
                    }
                }label: {
                    Text("Cancel")
                        .font(.callout)
                        .foregroundColor(.black)
                    
                }
                .hAlign(.leading)
                
                Button(action:createPost){
                    Text("Post")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                        .padding(.vertical,6)
                        .background(.black,in: Capsule())
                }
                .disableWithOpacity(postText == "")
            }
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background{
                Rectangle()
                    .fill(.gray.opacity(0.05))
                    .ignoresSafeArea()
            }
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 15){
                    
                    if let postImageData, let image = UIImage(data: postImageData){
                        GeometryReader{
                            let size = $0.size
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                                .overlay(alignment: .topTrailing) {
                                    Button{
                                        withAnimation(.easeInOut(duration: 0.25)){
                                            self.postImageData = nil
                                        }
                                    }label: {
                                        Image(systemName: "trash")
                                            .fontWeight(.bold)
                                            .tint(.red)
                                    }
                                    .padding(10)
                                }
                        }
                        .clipped()
                        .frame(height: 220)
                    }
                    TextField("What's happening",text: $postText,axis: .vertical)
                        .focused($showKeyboard)
                }
                .padding(15)
            }
            Divider()
            
            HStack{
                Button{
                    showImagePicker.toggle()
                }label: {
                    Image(systemName: "photo.on.rectangle")
                        .font(.title3)
                }
                .hAlign(.leading)
                
                Button("Done"){
                    showKeyboard = false
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal,15)
            .padding(.vertical,10)
        }
        .vAlign(.top)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem){
            newValue in
            if let newValue{
                Task{
                    if let rawImageData = try? await newValue.loadTransferable(type: Data.self),
                       let image = UIImage(data: rawImageData),
                       let compressedImageData = image.jpegData(compressionQuality: 0.5){
                        //MARK: UI must be done
                        await MainActor.run(body: {
                            postImageData = compressedImageData
                            photoItem = nil
                        })
                        
                    }
                }
            }
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        //MARK: loading view
        .overlay{
            LoadingView(show: $isloading)
        }
    }
    
    @ViewBuilder
    private var horizontalLayout: some View{
        VStack{
            HStack{
                Menu{
                    Button("Cancel",role: .destructive){
                        dismiss()
                    }
                }label: {
                    Text("Cancel")
                        .font(.callout)
                        .foregroundColor(.black)
                    
                }
                .hAlign(.leading)
                
                Button(action:createPost){
                    Text("Post")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                        .padding(.vertical,6)
                        .background(.black,in: Capsule())
                }
                .disableWithOpacity(postText == "")
            }
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background{
                Rectangle()
                    .fill(.gray.opacity(0.05))
                    .ignoresSafeArea()
            }
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 15){
                    HStack{
                        if let postImageData, let image = UIImage(data: postImageData){
                            GeometryReader{
                                let size = $0.size
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: size.width, height: size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                                    .overlay(alignment: .topTrailing) {
                                        Button{
                                            withAnimation(.easeInOut(duration: 0.25)){
                                                self.postImageData = nil
                                            }
                                        }label: {
                                            Image(systemName: "trash")
                                                .fontWeight(.bold)
                                                .tint(.red)
                                        }
                                        .padding(10)
                                    }
                            }
                            .clipped()
                            .frame(height: 220)
                        }
                        
                        TextField("What's happening",text: $postText,axis: .vertical)
                            .focused($showKeyboard)
                    }
                }
                .padding(15)
            }
            Divider()
            
            HStack{
                Button{
                    showImagePicker.toggle()
                }label: {
                    Image(systemName: "photo.on.rectangle")
                        .font(.title3)
                }
                .hAlign(.leading)
                
                Button("Done"){
                    showKeyboard = false
                }
            }
            .foregroundColor(.black)
            .padding(.horizontal,15)
            .padding(.vertical,10)
        }
        .vAlign(.top)
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem){
            newValue in
            if let newValue{
                Task{
                    if let rawImageData = try? await newValue.loadTransferable(type: Data.self),
                       let image = UIImage(data: rawImageData),
                       let compressedImageData = image.jpegData(compressionQuality: 0.5){
                        //MARK: UI must be done
                        await MainActor.run(body: {
                            postImageData = compressedImageData
                            photoItem = nil
                        })
                        
                    }
                }
            }
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        //MARK: loading view
        .overlay{
            LoadingView(show: $isloading)
        }
    }
    
    //MARK: post content to firebase
    func createPost(){
        isloading = true
        showKeyboard = false
        postText = PostTextRule(postText: postText)
        Task{
            do{
                guard let profileURL = profileURL else{return}
                
                let imageReferenceID = "\(userUID)\(Date())"
                let storageRef = Storage.storage().reference().child("Post_Images").child(imageReferenceID)
                if let postImageData{
                    let _ = try await storageRef.putDataAsync(postImageData)
                    let downloadURL = try await storageRef.downloadURL()
                    
                    let post = Post(text: postText, imageURL: downloadURL, imageReferenceID: imageReferenceID, userName: userName, userID: userUID, userProfileURL: profileURL)
                    try await createDocumentAtFirebase(post)
                }else{
                    let post = Post(text: postText, userName: userName, userID: userUID, userProfileURL: profileURL)
                    try await createDocumentAtFirebase(post)
                }
            }catch{
                await setError(error)
            }
        }
    }
    
    func createDocumentAtFirebase(_ post: Post) async throws{
        let doc = Firestore.firestore().collection("Posts").document()
        let _ = try doc.setData(from: post,completion: {
            error in
            if error == nil{
                //MARK: post successful stored at firebase
                isloading = false
                var updatedPost = post
                updatedPost.id = doc.documentID
                onPost(updatedPost)
                dismiss()
            }
        })
    }
    
    func setError(_ error: Error) async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    
    func PostTextRule(postText: String) -> String{
        if postText.count <= 0{
            return "Input Post Text"
        }else if postText.count > 30{
            return "Over maximum limit"
        }
        else{
            return postText
        }
    }
}

#Preview {
    CreateNewPost{
        _ in
    }
}


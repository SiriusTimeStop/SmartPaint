//
//  ReusableProfileContent.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

struct ReusableProfileContent: View {
    var user: User
    
    //MARK: coredata value
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var myImages: FetchedResults<MyImage>
    @StateObject private var imagePicker = CoreImagePicker()
    @State private var formType: FormType?
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVStack{
                HStack(spacing:12){
                    WebImage(url:user.userProfileURL).placeholder{
                        Image("NullProfile")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 6){
                        Text(user.username)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(user.userBio)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(3)
                        
                        if let bioLink = URL(string: user.userBioLink){
                            Link(user.userBioLink,destination: bioLink)
                                .font(.callout)
                                .tint(.blue)
                                .lineLimit(1)
                        }
                    }
                    .hAlign(.leading)
                }
                
                Text("My Image Store")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .hAlign(.leading)
                    .padding(.vertical,15)
                
                Group{
                    if !myImages.isEmpty{
                        ScrollView{
                            LazyVGrid(columns:columns,spacing: 20){
                                ForEach(myImages){
                                    myImage in
                                    Button {
                                        formType = .update(myImage)
                                    }label: {
                                        VStack{
                                            Image(uiImage: myImage.uiImage)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                                .shadow(radius: 5.0)
                                            Text(myImage.nameView)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }else{
                        Text("select your first image")
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .bottomBar){
                        PhotosPicker("Select Image",
                                     selection: $imagePicker.imageSelection,
                                     matching: .images,
                                     photoLibrary: .shared())
                        .buttonStyle(.borderedProminent)
                    }
                }
                .onChange(of: imagePicker.uiImage) { newImage in
                    if let newImage {
                        formType = .new(newImage)
                    }
                }
                .sheet(item: $formType) { $0
                }
            }
            .padding(15)
        }
    }
}

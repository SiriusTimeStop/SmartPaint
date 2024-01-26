//
//  ContentView.swift
//  ImageGeneratorApp
//
//  Created by jackychoi on 1/1/2024.
//MARK: Source Code refer to youtube "Build an AI Image Generator iOS App" https://www.youtube.com/watch?v=ynI2SCE_EPo

import SwiftUI

struct PromptView: View {
    @State var selectedStyle = ImageStyle.allCases[0]
    @State var promptText: String = ""
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            verticalLayout
        } else {
            horizontalLayout
        }
    }
    
    @ViewBuilder
    private var verticalLayout: some View {
        NavigationView {
            VStack(alignment:.leading){
                Text("Generate")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                Spacer()
                Text("Choose a style")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                
                GeometryReader{
                    reader in
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(ImageStyle.allCases,id: \.self) {
                                imageStyle in
                                Button {
                                    selectedStyle = imageStyle
                                } label: {
                                    Image(imageStyle.rawValue)
                                        .resizable()
                                        .background(Color.blue)
                                        .scaledToFill()
                                        .frame(width: reader.size.width*0.4,
                                               height:reader.size.width*0.4*1.4)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.yellow,
                                                        lineWidth: imageStyle == selectedStyle ? 3 : 0)
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                        }
                    }
                }
                Spacer()
                Text("Enter a prompt")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                TextEditor(text: $promptText)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .foregroundColor(.black)
                    .tint(Color.black)
                VStack{
                    NavigationLink {
                        GeneratorView(viewModel: .init(prompt: promptText, selectedStyle: selectedStyle))
                    } label: {
                        Text("Generate")
                            .foregroundColor(.black)
                            .padding(.horizontal,45)
                            .padding(.vertical,15)
                            .background(Color.yellow.opacity(0.7))
                            .cornerRadius(10)
                            .padding(.bottom,20)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.white
                .edgesIgnoringSafeArea(.all))
        }
    }
    
    @ViewBuilder
    private var horizontalLayout: some View {
        
        NavigationView {
            
            HStack{
                VStack(alignment:.leading){
                    Text("Generate")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                    Spacer()
                    Text("Choose a style")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)
                    
                    GeometryReader{
                        reader in
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(ImageStyle.allCases,id: \.self) {
                                    imageStyle in
                                    Button {
                                        selectedStyle = imageStyle
                                    } label: {
                                        Image(imageStyle.rawValue)
                                            .resizable()
                                            .background(Color.blue)
                                            .scaledToFill()
                                            .frame(width: reader.size.width*0.4,
                                                   height:reader.size.width*0.4*1.4)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color.yellow,
                                                            lineWidth: imageStyle == selectedStyle ? 3 : 0)
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                }
                            }
                        }
                    }
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundStyle(.black)
                    }
                }
                
                VStack(alignment:.center){
                    Text("Enter a prompt")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.vertical,30)
                    TextEditor(text: $promptText)
                        .scrollContentBackground(.hidden)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                        .foregroundColor(.black)
                        .tint(Color.black)
                        .frame(width:250,height:200)
                    VStack{
                        NavigationLink {
                            GeneratorView(viewModel: .init(prompt: promptText, selectedStyle: selectedStyle))
                        } label: {
                            Text("Generate")
                                .foregroundColor(.black)
                                .padding(.horizontal,45)
                                .padding(.vertical,15)
                                .background(Color.yellow.opacity(0.7))
                                .cornerRadius(10)
                                .padding(.bottom,20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color.white
                .edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    PromptView()
}

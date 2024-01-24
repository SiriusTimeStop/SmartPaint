//
//  GeneratorView.swift
//  ImageGeneratorApp
//
//  Created by jackychoi on 2/1/2024.
//MARK: Source Code follow to youtube "Build an AI Image Generator iOS App" https://www.youtube.com/watch?v=ynI2SCE_EPo

import SwiftUI

struct GeneratorView: View {
    @ObservedObject var viewModel: ViewModel
    
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
        VStack(alignment: .leading){
            Text("Generated Image")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
            VStack{
                Text("Time spent: \("")")
                AsyncImage(url: viewModel.image) { image in
                    image.resizable().aspectRatio(1, contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .background(Color.gray.opacity(0.2))
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .cornerRadius(20)
                .clipped()
                // Add a button to save the image
                Button{
                    // Get the URL of the image
                    guard let url = viewModel.image else {
                        return
                    }
                    
                    // Save the image to the phone
                    saveImage(url: url)
                }label: {
                    Text("Download")
                        .foregroundColor(.black)
                        .padding(.horizontal,45)
                        .padding(.vertical,15)
                        .background(Color.yellow.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.bottom,20)
                }
                .padding(.top,20)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .onAppear{
            viewModel.generateImage()
        }
    }
    
    @ViewBuilder
    private var horizontalLayout: some View{
            VStack(alignment: .center){
                Text("Generated Image")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                
                HStack(alignment:.center,spacing: 180){
                    VStack(alignment:.center){
                        Text("Time spent: \("")")
                        AsyncImage(url: viewModel.image) { image in
                            image.resizable().aspectRatio(1, contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .background(Color.gray.opacity(0.2))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                        .clipped()
                    }
                
                VStack(alignment:.center){
                    Button{
                        // Get the URL of the image
                        guard let url = viewModel.image else {
                            return
                        }
                        
                        // Save the image to the phone
                        saveImage(url: url)
                    }label: {
                        Text("Download")
                            .foregroundColor(.black)
                            .padding(.horizontal,45)
                            .padding(.vertical,15)
                            .background(Color.yellow.opacity(0.7))
                            .cornerRadius(10)
                            .padding(.bottom,20)
                    }
                    .padding(.top,20)
                }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white.edgesIgnoringSafeArea(.all))
                .onAppear{
                    viewModel.generateImage()
                }
            }
        }
    
    func saveImage(url: URL) {
        // Create a UIImage from the URL
        guard let imageData = try? Data(contentsOf: url),
              let uiImage = UIImage(data: imageData) else {
            return
        }
        
        // Save the image to the phone's photo album
        UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
    }
}

#Preview {
    GeneratorView(viewModel: .init(prompt: "red car", selectedStyle: .threeDRender))
}

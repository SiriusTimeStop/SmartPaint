//
//  GeneratorView.swift
//  ImageGeneratorApp
//
//  Created by jackychoi on 2/1/2024.
//

import SwiftUI

struct GeneratorView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
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
//
//#Preview {
//    GeneratorView(viewModel: .init(prompt: "red car", selectedStyle: .threeDRender))
//}

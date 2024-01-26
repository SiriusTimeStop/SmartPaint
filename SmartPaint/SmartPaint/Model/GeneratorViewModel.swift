//
//  GeneratorViewModel.swift
//  ImageGeneratorApp
//
//  Created by jackychoi on 2/1/2024.
//MARK: Source Code refer to youtube "Build an AI Image Generator iOS App" https://www.youtube.com/watch?v=ynI2SCE_EPo

import Foundation

extension GeneratorView{
    class ViewModel: ObservableObject{
        @Published var duration = 0
        @Published var image: URL?
        
        let prompt: String
        let selectedStyle: ImageStyle
        
        private let openAIService = OpenAIService()
            
        init(prompt: String, selectedStyle: ImageStyle) {
            self.prompt = prompt
            self.selectedStyle = selectedStyle
        }
        
        func generateImage(){
            let formattedPrompt = "\(selectedStyle.title) iamge of \(prompt)"
            
            Task{
                do{
                    let generatedImage = try await openAIService.generateImage(prompt: formattedPrompt)
                    guard let imageURLString = generatedImage.data.first?.url,
                          let imageUrl = URL(string: imageURLString) else {
                        print("Failed to generate image")
                        return
                    }
                    await MainActor.run {
                        self.image = imageUrl
                    }
                }catch{
                    print(error)
                }
            }
        }
    }
    
}

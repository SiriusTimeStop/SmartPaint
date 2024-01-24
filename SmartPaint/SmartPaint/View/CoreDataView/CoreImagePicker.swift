//
//  ImagePicker.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//MARK: Source Code follow to youtube "My Images Core Data" https://www.youtube.com/watch?v=og1R6HIYU5c&list=PLBn01m5Vbs4DYmnxdD1ZuEJA7yXqHcSEd&index=1

import SwiftUI
import PhotosUI

@MainActor
class CoreImagePicker: ObservableObject{
    @Published var imageSelection: PhotosPickerItem?{
        didSet{
            Task{
                try await loadTransferable(from:imageSelection)
            }
        }
    }
    @Published var image: Image?
    @Published var uiImage: UIImage?
    
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws{
        do{
            if let data = try await imageSelection?.loadTransferable(type: Data.self){
                if let uiImage = UIImage(data: data){
                    self.uiImage = uiImage
                    self.image = Image(uiImage: uiImage)
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}

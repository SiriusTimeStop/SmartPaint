//
//  FormViewModel.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//MARK: Source Code refer to youtube "My Images Core Data" https://www.youtube.com/watch?v=og1R6HIYU5c&list=PLBn01m5Vbs4DYmnxdD1ZuEJA7yXqHcSEd&index=1

import UIKit

class FormViewModel: ObservableObject{
    @Published var name = ""
    @Published var uiImage: UIImage
    
    var id: String?
    
    var updating: Bool{
        id != nil
    }
    
    init(_ uiImage: UIImage){
        self.uiImage = uiImage
    }
    
    init(_ myImage: MyImage){
        name = myImage.nameView
        id = myImage.imageID
        uiImage = myImage.uiImage
    }
    
    var incomplete: Bool{
        name.isEmpty || uiImage == UIImage(systemName: "photo")!
    }
}

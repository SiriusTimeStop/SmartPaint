//
//  FormViewModel.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//

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

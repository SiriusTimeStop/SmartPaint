//
//  MyImage+Extension.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//

import UIKit

extension MyImage{
    var nameView: String{
        name ?? ""
    }
    
    var imageID: String{
        id ?? ""
    }
    
    var uiImage: UIImage{
        if !imageID.isEmpty,
           let image = FileManager().retrieveImage(with: imageID){
            return image
        }else{
            return UIImage(systemName: "photo")!
        }
    }
}

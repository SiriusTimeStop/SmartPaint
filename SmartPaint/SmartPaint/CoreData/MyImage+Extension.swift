//
//  MyImage+Extension.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//MARK: Source Code refer to youtube "Build an AI Image Generator iOS App" https://www.youtube.com/watch?v=ynI2SCE_EPo

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

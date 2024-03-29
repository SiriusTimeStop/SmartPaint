//
//  FileManager+Extension.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//MARK: Source Code refer to youtube "My Images Core Data" https://www.youtube.com/watch?v=og1R6HIYU5c&list=PLBn01m5Vbs4DYmnxdD1ZuEJA7yXqHcSEd&index=1


import UIKit

extension FileManager{
        
    func retrieveImage(with id: String) -> UIImage?{
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        do{
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveImage(with id: String, image: UIImage){
        if let data = image.jpegData(compressionQuality: 0.6){
            do{
                let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
                try data.write(to: url)
            }catch{
                print(error.localizedDescription)
            }
        }else{
            print("Could not save image")
        }
    }
    
    func deleteImage(with id: String){
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        if fileExists(atPath: url.path){
            do{
                try removeItem(at: url)
            }catch{
                print(error.localizedDescription)
            }
        }else{
            print("Image does not exist")
        }
    }
}

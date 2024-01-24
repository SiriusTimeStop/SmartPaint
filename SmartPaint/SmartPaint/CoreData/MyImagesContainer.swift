//
//  MyImageContainer.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//MARK: Source Code follow to youtube "Build an AI Image Generator iOS App" https://www.youtube.com/watch?v=ynI2SCE_EPo

import Foundation
import CoreData

class MyImagesContainer{
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MyImagesDataModel")
        persistentContainer.loadPersistentStores{
            _, error in
            if let error{
                print(error.localizedDescription)
            }
        }
    }
}

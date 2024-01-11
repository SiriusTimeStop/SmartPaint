//
//  MyImageContainer.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//

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

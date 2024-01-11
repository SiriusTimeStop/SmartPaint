//
//  SmartPaintApp.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//

import SwiftUI
import Firebase

@main
struct SmartPaintApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,MyImagesContainer().persistentContainer.viewContext)
                .onAppear{
                    print(URL.documentsDirectory.path)
                }
        }
    }
}

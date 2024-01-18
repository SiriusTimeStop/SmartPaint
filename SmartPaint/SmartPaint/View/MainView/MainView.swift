//
//  MainView.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        //MARK: TabView
        TabView{
            PostView()
                .tabItem {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Post's")
                }
            
            ImagePredictView()
                .tabItem {
                    Image(systemName: "doc.text.image")
                    Text("AI Predict")
                }
            
            DrawMenuView()
                .tabItem {
                    Image(systemName: "pencil.and.scribble")
                    Text("Draw")
                }
            
            LocationMenuView()
                .tabItem {
                    Image(systemName: "filemenu.and.selection")
                    Text("Museum")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Profile")
                }
        }
        .animation(.easeInOut(duration: 0.3).delay(0.2))
        .tint(.black)
    }
}

#Preview {
    ContentView()
}

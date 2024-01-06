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
            PaintingMediaView()
                .tabItem {
                    Image(systemName: "filemenu.and.selection")
                    Text("Paint Media")
                }
            
            DrawingView()
                .tabItem {
                    Image(systemName: "pencil.and.scribble")
                    Text("Draw")
                }
            
            PromptView()
                .tabItem{
                    Image(systemName: "photo.on.rectangle.angled")
                    Text("AI Image")
                }
            
            PostView()
                .tabItem {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Post's")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Profile")
                }
        }
        .tint(.black)
    }
}

#Preview {
    ContentView()
}

//
//  DrawMenuView.swift
//  SmartPaint
//
//  Created by jackychoi on 10/1/2024.
//

import SwiftUI
import SlidingTabView

struct DrawMenuView: View {
    @State private var sheetPresented = false
    @State private var sheetPresentedAI = false
    @State private var tabIndex = 0
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            verticalLayout
        } else {
            horizontalLayout
        }
    }
    
    @ViewBuilder
    private var verticalLayout: some View{
        NavigationView{
            VStack{
                Button(action: {
                    sheetPresented = true
                }){
                    VStack{
                        Image("ManualDraw")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(30)
                        
                        Text("User Draw")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .sheet(isPresented:$sheetPresented){
                        DrawingView()
                    }
                }
                
                Button(action: {
                    sheetPresentedAI = true
                    
                }){
                    VStack{
                        Image("AIDraw")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(30)
                        
                        Text("AI Draw")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .sheet(isPresented:$sheetPresentedAI){
                        PromptView()
                    }
                }
                .padding(.top,30)
            }
            .navigationBarTitle("Draw and Paint")
            .listStyle(.plain)
        }
    }
    
    @ViewBuilder
    private var horizontalLayout: some View{
        NavigationView{
            HStack(spacing:100){
                VStack{
                    Button(action: {
                        sheetPresented = true
                    }){
                        VStack{
                            Image("ManualDraw")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .cornerRadius(30)
                            
                            Text("User Draw")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                        .sheet(isPresented:$sheetPresented){
                            DrawingView()
                        }
                    }
                }
                
                VStack{
                    Button(action: {
                        sheetPresentedAI = true
                        
                    }){
                        VStack{
                            Image("AIDraw")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .cornerRadius(30)
                            
                            Text("AI Draw")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                        .sheet(isPresented:$sheetPresentedAI){
                            PromptView()
                        }
                    }
                }
            }
            .navigationBarTitle("Draw and Paint")
            .listStyle(.plain)
        }
    }
}

#Preview {
    DrawMenuView()
}

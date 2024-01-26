//
//  LocationMenuView.swift
//  SmartPaint
//
//  Created by jackychoi on 18/1/2024.
//MARK: Source Code refer to youtube "How to Get User Location on a Map" https://www.youtube.com/watch?v=hWMkimzIQoU&t=1351s

import SwiftUI
import SlidingTabView

struct LocationMenuView: View {
    
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
                        Image("HongKongLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(30)
                        
                        Text("Hong Kong Museum")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .sheet(isPresented:$sheetPresented){
                        LocationGpsView()
                    }
                }
                
                Button(action: {
                    sheetPresentedAI = true
                    
                }){
                    VStack{
                        Image("WorldLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(30)
                        
                        Text("World Museum")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                    .sheet(isPresented:$sheetPresentedAI){
                        LocationView()
                    }
                }
                .padding(.top,30)
            }
            .navigationBarTitle("Museum Location")
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
                            Image("HongKongLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .cornerRadius(30)
                            
                            Text("Hong Kong Museum")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                        .sheet(isPresented:$sheetPresented){
                            LocationGpsView()
                        }
                    }
                }
                
                VStack{
                    Button(action: {
                        sheetPresentedAI = true
                        
                    }){
                        VStack{
                            Image("WorldLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .cornerRadius(30)
                            
                            Text("World Museum")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        }
                        .sheet(isPresented:$sheetPresentedAI){
                            LocationView()
                        }
                    }
                }
            }
            .navigationBarTitle("Museum Location")
            .listStyle(.plain)
        }
    }
}

#Preview {
    LocationMenuView()
}

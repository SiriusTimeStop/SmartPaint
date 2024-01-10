//
//  DrawMenuView.swift
//  SmartPaint
//
//  Created by jackychoi on 10/1/2024.
//

import SwiftUI

struct DrawMenuView: View {
    @State private var sheetPresented = false
    @State private var sheetPresentedAI = false
    var body: some View {
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
                    
                    Text("Manual Draw")
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
    }
}

#Preview {
    DrawMenuView()
}

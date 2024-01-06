//
//  PaintingMediaView.swift
//  SmartArt
//
//  Created by jackychoi on 3/1/2024.
//

import SwiftUI

struct PaintingMediaView: View {
    var body: some View {
        ZStack{
            NavigationView{
                List(PaintStyleArray){ paintStyle in
                    NavigationLink(destination: PaintStyleDetail()){
                        PaintStyleRow(paintStyle: paintStyle)
                    }
                }
                .navigationBarTitle("Paint Style")
                .listStyle(.plain)
            }
        }
    }
}

struct PaintStyleRow: View {
    
    let paintStyle: PaintStyle
    var body: some View {
        HStack {
            Image(paintStyle.paintStyleImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150,height: 150)
            VStack(alignment: .leading){
                Text(paintStyle.paintStyleName)
                    .font(.system(size: 21,weight: .medium,design: .default))
                    .padding(.leading)
            }
        }
    }
}

#Preview {
    PaintingMediaView()
}

//
//  LoadingView.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//MARK: Source Code follow to youtube "SwiftUI Social Media App - Firebase" https://www.youtube.com/watch?v=-pAQcPolruw&t=1279s

import SwiftUI

struct LoadingView: View {
    @Binding var show: Bool
    var body: some View {
        ZStack{
            if show{
                Group{
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding(15)
                        .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
        .animation(.easeInOut(duration: 0.25),value: show)
    }
}

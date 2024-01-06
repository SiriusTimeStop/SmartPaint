//
//  ContentView.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus{
            Text("Main View")
        }else{
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}

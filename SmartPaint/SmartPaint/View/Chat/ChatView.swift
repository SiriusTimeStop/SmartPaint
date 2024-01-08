//
//  ChatView.swift
//  SmartPaint
//
//  Created by jackychoi on 8/1/2024.
//

import SwiftUI
import GoogleGenerativeAI

struct ChatView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: "")
    @State var textInput = ""
    @State var aiResponse = "Hello"
    var body: some View {
        VStack{
            Image("LouvreImage")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            //MARK: AI resposne
            ScrollView{
                Text(aiResponse)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
            }
            
            HStack{
                TextField("Enter a message", text: $textInput)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(.black)
                Button(action:{
                    
                },label: {
                    Image(systemName: "paperplane.fill")
                })
            }
        }
        .foregroundStyle(.white)
        .padding()
        .background{
            ZStack{
                Color.black
            }
            .ignoresSafeArea()
        }
    }
    
    //MARK: fetch response
    func sendMessage(){
        aiResponse = ""
        Task{
            do{
                let response = try await model.generateContent(textInput)
                
                guard let text = response.text else{
                    textInput = "Sorry, I could not process that. \nPlease try again"
                    return
                }
                
                textInput = ""
                aiResponse = text
            }catch{
                aiResponse = "Something went wrong \n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ChatView()
}

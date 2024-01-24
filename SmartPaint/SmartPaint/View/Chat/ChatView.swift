//
//  MultiurnChatView.swift
//  SmartPaint
//
//  Created by jackychoi on 8/1/2024.
//MARK: Source Code follow to youtube "Multi-turn Chat with Gemini AI on iOS" SwiftUI Tutorial https://www.youtube.com/watch?v=VO3YGN2UuHc&t=4s

import SwiftUI

struct ChatView: View {
    @State var textInput = ""
    @State var logoAnimating = false
    @State var timer: Timer?
    @State var chatService = ChatService()
    
    var body: some View {
        VStack{
            Image(.aiLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .opacity(logoAnimating ? 0.5 : 1)
                .animation(.easeInOut, value: logoAnimating)
            
            ScrollViewReader(content: { proxy in
                ScrollView{
                    ForEach(chatService.messages) {
                        ChatMessage in
                        chatMessageView(ChatMessage)
                    }
                }
                .onChange(of: chatService.messages) { _, _ in
                    guard let recentMessage = chatService.messages.last else {return}
                    DispatchQueue.main.async {
                        withAnimation {
                            proxy.scrollTo(recentMessage.id,anchor: .bottom)
                        }
                    }
                }
                .onChange(of: chatService.loadingResponse) { _, newValue in
                    if newValue{
                        startLoadingAnimation()
                    }else{
                        stopLoadingAnimation()
                    }
                }
            })
            
            HStack{
                TextField("Enter a message...",text: $textInput)
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(.black)
                
                Button(action: sendMessage){
                    Image(systemName: "paperplane.fill")
                }
            }
        }
        .foregroundStyle(.black)
        .padding()
        .background{
            ZStack{
                Color.white
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder func chatMessageView(_ message: ChatMessage) -> some View{
        ChatBubble(direction: message.role == .model ? .left : .right){
            Text(message.message)
                .font(.title3)
                .padding(.all,20)
                .foregroundStyle(.white)
                .background(message.role == .model ? Color.gray : Color.brown)
        }
    }
    
    func sendMessage(){
        textInput = MessageTextRule(textInput: textInput)
        chatService.sendMessage(textInput)
        textInput = ""
    }
    
    func startLoadingAnimation(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            logoAnimating.toggle()
        })
    }
    
    func stopLoadingAnimation(){
        logoAnimating = false
        timer?.invalidate()
        timer = nil
    }
    
    func MessageTextRule(textInput: String) -> String{
        if textInput.count <= 0{
            return "Input Message"
        }else if textInput.count > 50{
            return "Over maximum limit"
        }
        else{
            return textInput
        }
    }
}

#Preview {
    ChatView()
}

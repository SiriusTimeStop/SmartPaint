//
//  ChatBubble.swift
//  GeminiChat
//
//  Created by Anup D'Souza
//MARK: Source Code follow to youtube "Multi-turn Chat with Gemini AI on iOS" SwiftUI Tutorial https://www.youtube.com/watch?v=VO3YGN2UuHc&t=4s

import Foundation
import SwiftUI

struct ChatBubble<Content>: View where Content: View {
    let direction: ChatBubbleShape.Direction
    let content: () -> Content
    init(direction: ChatBubbleShape.Direction, @ViewBuilder content: @escaping () -> Content) {
            self.content = content
            self.direction = direction
    }
    
    var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            content()
                .clipShape(ChatBubbleShape(direction: direction))
            if direction == .left {
                Spacer()
            }
        }.padding([(direction == .left) ? .leading : .trailing, .top, .bottom], 20)
        .padding((direction == .right) ? .leading : .trailing, 50)
    }
}

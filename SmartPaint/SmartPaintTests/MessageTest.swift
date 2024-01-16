//
//  MessageTest.swift
//  SmartPaintTests
//
//  Created by jackychoi on 16/1/2024.
//

import XCTest
@testable import SmartPaint

final class MessageTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testChatBotEmpty() throws{
        let chatBot = ChatView()
        let userMessage = ""
        
        let usd = chatBot.MessageTextRule(textInput: userMessage)
        let expected = "Input Message"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }
    
    func testChatBot() throws{
        let chatBot = ChatView()
        let userMessage = "abcdefg"
        
        let usd = chatBot.MessageTextRule(textInput: userMessage)
        let expected = "abcdefg"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }
    
    func testChatBotMax() throws{
        let chatBot = ChatView()
        let userMessage = "abcdefjhijklmnopqrstuvwxyz"
        
        let repeatStr = String(repeating: userMessage, count: 30)
        let usd = chatBot.MessageTextRule(textInput: repeatStr)
        let expected = "Over maximum limit"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

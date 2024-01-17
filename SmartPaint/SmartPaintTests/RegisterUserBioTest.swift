//
//  RegisterUserBioTest.swift
//  SmartPaintTests
//
//  Created by jackychoi on 16/1/2024.
//

import XCTest
@testable import SmartPaint

final class RegisterUserBioTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBioRuleEmpty() throws{
        let register = RegisterView()
        let userBio = ""
        
        let usd = register.BioRule(userBio: userBio)
        let expected = "Welcome to SmartPaint"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }
    
    func testBioRule() throws{
        let register = RegisterView()
        let userBio = "abcd"
        
        let usd = register.BioRule(userBio: userBio)
        let expected = "abcd"
        XCTAssertEqual(usd, expected, "Test faild.")
    }
    
    func testBioRuleTextMax() throws{
        let register = RegisterView()
        let userBio = "abcdefjhijklmnopqrstuvwxyz"
        
        let repeatStr = String(repeating: userBio, count: 30)
        let usd = register.BioRule(userBio: repeatStr)
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

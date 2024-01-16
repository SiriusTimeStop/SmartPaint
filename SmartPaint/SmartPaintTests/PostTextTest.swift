//
//  PostTextTest.swift
//  SmartPaintTests
//
//  Created by jackychoi on 16/1/2024.
//

import XCTest
@testable import SmartPaint

final class PostTextTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPostTextEmpty() throws{
        let post = ""
        
        let usd = PostTextRule(postText: post)
        let expected = "Input Post Text"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }
    
    
    func testPostText() throws{
        let post = "abcdef"
        
        let usd = PostTextRule(postText: post)
        let expected = "abcdef"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }
    
    func testPostTextMax() throws{
        let post = "abcdefjhijklmnopqrstuvwxyzabcdefghijklmnop"
        
        let usd = PostTextRule(postText: post)
        let expected = "Over maximum limit"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }

    func PostTextRule(postText: String) -> String{
        if postText.count <= 0{
            return "Input Post Text"
        }else if postText.count > 30{
            return "Over maximum limit"
        }
        else{
            return postText
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

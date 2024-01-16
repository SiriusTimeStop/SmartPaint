//
//  ImageTextTest.swift
//  SmartPaintTests
//
//  Created by jackychoi on 16/1/2024.
//

import XCTest
@testable import SmartPaint

final class ImageTextTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageFormEmpty() throws{
        let imageText = ""
        
        let usd = ImageTextRule(imageText: imageText)
        let expected = "Input Image Name"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }
    
    func testImageForm() throws{
        let imageText = "abcdef"
        
        let usd = ImageTextRule(imageText: imageText)
        let expected = "abcdef"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }
    
    func testImageFormMax() throws{
        let imageText = "abcdefjhijklmnopqrstuvwxyzabcdefghijklmnop"
        
        let usd = ImageTextRule(imageText: imageText)
        let expected = "Over maximum limit"
        
        XCTAssertEqual(usd, expected, "Test faild.")
    }
    
    func ImageTextRule(imageText: String) -> String{
        if imageText.count <= 0{
            return "Input Image Name"
        }else if imageText.count > 15{
            return "Over maximum limit"
        }
        else{
            return imageText
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

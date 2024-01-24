//
//  APIKey.swift
//  SmartPaint
//
//  Created by jackychoi on 8/1/2024.
//MARK: Source Code follow to youtube "Multi-turn Chat with Gemini AI on iOS" SwiftUI Tutorial https://www.youtube.com/watch?v=VO3YGN2UuHc&t=4s

import Foundation

enum APIKey{
    
    static var `default`: String{
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
        else{
            fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else{
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        if value.starts(with: "_"){
            fatalError(
                "Setup to get an API key"
            )
        }
        return value
    }
}

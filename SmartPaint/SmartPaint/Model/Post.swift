//
//  Post.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//MARK: Source Code refer to youtube "SwiftUI Social Media App - Firebase" https://www.youtube.com/watch?v=-pAQcPolruw&t=1279s

import SwiftUI
import FirebaseFirestoreSwift

//MARK: post model
struct Post: Identifiable,Codable{
    @DocumentID var id: String?
    var text: String
    var imageURL: URL?
    var imageReferenceID: String = ""
    var publishedDate: Date = Date()
    var likedIDs: [String] = []
    var dislikedIDs: [String] = []
    var userName: String
    var userID: String
    var userProfileURL: URL
    
    enum CodingKeys: CodingKey{
        case id
        case text
        case imageURL
        case imageReferenceID
        case publishedDate
        case likedIDs
        case dislikedIDs
        case userName
        case userID
        case userProfileURL
    }
}

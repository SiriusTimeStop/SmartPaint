//
//  User.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//MARK: Source Code follow to youtube "SwiftUI Social Media App - Firebase" https://www.youtube.com/watch?v=-pAQcPolruw&t=1279s

import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var username: String
    var userBio: String
    var userUID: String
    var userEmail: String
    var userProfileURL: URL
    
    enum CodingKeys: CodingKey{
        case id
        case username
        case userBio
        case userUID
        case userEmail
        case userProfileURL
    }
}

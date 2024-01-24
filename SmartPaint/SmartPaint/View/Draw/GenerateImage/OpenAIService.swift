//
//  OpenAIService.swift
//  ImageGeneratorApp
//
//  Created by jackychoi on 2/1/2024.
//MARK: Source Code follow to youtube "Build an AI Image Generator iOS App" https://www.youtube.com/watch?v=ynI2SCE_EPo

import Foundation
import Alamofire

class OpenAIService{
    private let endpointUrl = "https://api.openai.com/v1/images/generations"
    
    func generateImage(prompt: String) async throws -> OpenAIImageResponse{
        let body = OpenAIImageRequestBody(prompt: prompt, size: "512x512")
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAPIKey)"
        ]
        
        return try await AF.request(endpointUrl, method: .post, parameters: body,encoder:.json, headers: headers).serializingDecodable(OpenAIImageResponse.self).value
    }
}

struct OpenAIImageResponse: Decodable{
    let data: [OpenAIImageURL]
}

struct OpenAIImageURL: Decodable{
    let url: String
}

struct OpenAIImageRequestBody: Encodable{
    let prompt: String
    let size: String
}

//
//  ImageStyle.swift
//  ImageGeneratorApp
//
//  Created by jackychoi on 1/1/2024.
//MARK: Source Code refer to youtube "Build an AI Image Generator iOS App" https://www.youtube.com/watch?v=ynI2SCE_EPo

import Foundation

enum ImageStyle: String, CaseIterable{
    case waterColor1
    case oilPaint1
    case gouache1
    case inkWashPaint1
    case charcoal1
    case threeDRender
    
    
    var title: String{
        switch self {
        case .waterColor1:
            return "Watercolor painting"
        case .oilPaint1:
            return "Oil Painting"
        case .gouache1:
            return "Gouache"
        case.inkWashPaint1:
            return "Ink Wash Painting"
        case .charcoal1:
            return "Charcoal"
        case .threeDRender:
            return "3D Render"
        }
    }
}

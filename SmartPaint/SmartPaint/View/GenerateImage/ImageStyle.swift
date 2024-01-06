//
//  ImageStyle.swift
//  ImageGeneratorApp
//
//  Created by jackychoi on 1/1/2024.
//

import Foundation

enum ImageStyle: String, CaseIterable{
    case waterColor1
    case oilPaint1
    case gouache1
    case inkWashPaint1
    case charcoal1
    case surrealism
    case realism
    case threeDRender
    case minimalism
    case abstract
    case retro
    case geometric
    
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
        case .surrealism:
            return "Surrealism"
        case .realism:
            return "Realism"
        case .threeDRender:
            return "3D Render"
        case .minimalism:
            return "Minimalism"
        case .abstract:
            return "Abstract"
        case .retro:
            return "Retro"
        case .geometric:
            return "Geometric"
        }
    }
}

//
//  Clothing.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 06/11/25.
//

import Foundation
import SwiftData

@Model
final class Clothing {
    
    @Attribute(.externalStorage)
    var image: Data?
    
    var clothingType: ClothingType
    var outfits: [Outfit] = []
    
    init(image: Data? = nil, clothingType: ClothingType) {
        self.image = image
        self.clothingType = clothingType
    }
}

enum ClothingType: String, CaseIterable, Identifiable, Codable {
    case headwear
    case upperwear
    case lowerwear
    case footwear
    
    func emoji() -> String {
        switch self {
        case .headwear: "👒"
        case .upperwear: "👚"
        case .lowerwear: "👖"
        case .footwear: "👟"
        }
    }
    var id: Self { self }
}

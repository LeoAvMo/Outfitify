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
    
    var clothingType: ClothingType.RawValue
    var outfits: [Outfit]?
    
    init(image: Data? = nil, clothingType: ClothingType = .topwear) {
        self.image = image
        self.clothingType = clothingType.rawValue
    }
}

enum ClothingType: String, CaseIterable, Identifiable, Codable {
    case headwear = "Headwear"
    case topwear = "Upperwear & Full Body"
    case lowerwear = "Lowerwear"
    case footwear = "Footwear"
    
    func emoji() -> String {
        switch self {
        case .headwear: return "👒"
        case .topwear: return "👚"
        case .lowerwear: return "👖"
        case .footwear: return "👟"
        }
    }
    var id: Self { self }
}

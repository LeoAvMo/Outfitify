//
//  Outfit.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 11/11/25.
//

import SwiftUI
import SwiftData

@Model
final class Outfit {
    
    @Attribute(.externalStorage)
    var image: Data?
    
    @Relationship(inverse: \Clothing.outfits)
    var clothes: [Clothing] = []
    
    @Relationship(inverse: \Accessory.outfits)
    var accessories: [Accessory] = []
    
    init(image: Data? = nil) {
        self.image = image
    }
    
}

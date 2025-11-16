//
//  Accessory.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 07/11/25.
//

import SwiftUI
import SwiftData

@Model
final class Accessory {
    
    @Attribute(.externalStorage)
    var image: Data?
    
    var outfits: [Outfit] = []
    
    init(image: Data? = nil) {
        self.image = image
    }
}

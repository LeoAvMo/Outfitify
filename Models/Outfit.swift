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
    var image: String
    // var clothes: [Clothing]
    // var accessories: [Accessory]
    
    init(image: String = "") {
        self.image = image
    }
}

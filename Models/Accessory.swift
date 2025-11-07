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
    var image: String
    
    init(image: String = "placeholderAccessory") {
        self.image = image
    }
}

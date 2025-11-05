//
//  Item.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

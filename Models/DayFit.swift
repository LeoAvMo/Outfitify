//
//  DayFit.swift
//  Outfitify
//
//  Created by Leo A.Molina on 12/11/25.
//

import SwiftUI
import SwiftData

@Model
final class DayFit {
    
    var date: Date
    var outfit: Outfit?
    
    init(date: Date = Date.now, outfit: Outfit? = nil) {
        self.date = date
        self.outfit = outfit
    }
}

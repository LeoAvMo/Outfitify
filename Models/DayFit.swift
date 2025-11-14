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
    @Attribute(.externalStorage)
    var image: Data?
    
    
    init(date: Date = Date.now, image: Data? = nil){
        self.date = date
        self.image = image
    }
}

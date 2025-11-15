//
//  Ext+Calendar.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import Foundation

extension Calendar {
    static let gregorian: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        
        
        calendar.firstWeekday = 2
        
        return calendar
    }()
}

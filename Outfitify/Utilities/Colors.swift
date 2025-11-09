//
//  Colors.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 09/11/25.
//

import SwiftUI

struct GenerableColor: Hashable{
    let name: String
    let color: Color
}

let generableColors: [GenerableColor] = [
    GenerableColor(name: "Red",    color: .red),
    GenerableColor(name: "Orange", color: .orange),
    GenerableColor(name: "Yellow", color: .yellow),
    GenerableColor(name: "Green",  color: .green),
    GenerableColor(name: "Blue",   color: .blue),
    GenerableColor(name: "Indigo", color: .indigo),
    GenerableColor(name: "Purple", color: .purple),
    GenerableColor(name: "Pink",   color: Color(red: 251/255, green: 117/255, blue: 166/255)),
    GenerableColor(name: "White",  color: .white),
    GenerableColor(name: "Black",  color: .black),
    GenerableColor(name: "Brown",  color: .brown)
]

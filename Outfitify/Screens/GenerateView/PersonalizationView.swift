//
//  PersonalizationView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 09/11/25.
//

import SwiftUI


struct PersonalizationView: View {
    @State public var clothingType: ClothingType
    @State private var color: Color = .red
    var body: some View {
        NavigationStack {
            Form {
                Picker(selection: $color, label: Text("Color")) {
                    ForEach(generableColors, id: \.self) { col in
                        ColorWithLabel(color: col.color, label: col.name).tag(col)
                    }
                }
                .pickerStyle(.navigationLink)
            }
            .navigationTitle(Text("Create \(clothingType.rawValue)"))
        }
    }
}

#Preview {
    PersonalizationView(clothingType: .headwear)
}

struct ColorWithLabel: View {
    var color: Color
    var label: String
    var body: some View {
        HStack{
            Circle()
                .foregroundStyle(color)
            Text(label)
        }
        
    }
}

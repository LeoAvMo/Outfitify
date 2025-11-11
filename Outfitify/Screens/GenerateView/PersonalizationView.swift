//
//  PersonalizationView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 09/11/25.
//

import SwiftUI
import ImagePlayground

struct PersonalizationView: View {
    @State public var clothingType: ClothingType
    @State private var selectedColor: GenerableColor?
    @State private var style: String?
    @State private var weather: String?
    @State private var pattern: String?
    
    
    @State private var showSheet = false
    @State private var createdImageURL: URL? = nil
    @Environment(\.supportsImagePlayground) private var supportsImagePlayground
    
    var body: some View {
        
        var clothingTypeString: String {
            if clothingType == .topwear {
                return "T-Shirt"
            } else {
                return clothingType.rawValue
            }
        }
        
        NavigationStack {
            Form {
                Picker(selection: $selectedColor, label: Text("Color")) {
                    ForEach(generableColors, id: \.self) { col in
                        ColorWithLabel(color: col.color, label: col.name).tag(col)
                    }
                }
                .pickerStyle(.navigationLink)
                
                Picker(selection: $style, label: Text("Style")) {
                    ForEach(styles, id: \.self) { style in
                        Text(style).tag(style)
                    }
                }
                .pickerStyle(.navigationLink)
                
                Picker(selection: $weather, label: Text("Weather")) {
                    ForEach(weathers, id: \.self) { weather in
                        Text(weather).tag(weather)
                    }
                }
                .pickerStyle(.navigationLink)
                
                Picker(selection: $pattern, label: Text("Pattern")) {
                    ForEach(patterns, id: \.self) { pattern in
                        Text(pattern).tag(pattern)
                    }
                }
                .pickerStyle(.navigationLink)
                
                
            }
            .navigationTitle(Text("Create \(clothingType.rawValue)"))
            
            if supportsImagePlayground {
              Button("Generate Clothing") {
                showSheet = true
              }
              .buttonStyle(.glassProminent)
              .disabled(selectedColor == nil ||
                        style == nil ||
                        weather == nil ||
                        pattern == nil)
              .imagePlaygroundSheet(
                    isPresented: $showSheet,
                    concepts: [
                        ImagePlaygroundConcept.text("\(clothingTypeString)"),
                        ImagePlaygroundConcept.text("\(selectedColor?.name ?? "Red")"),
                        ImagePlaygroundConcept.text("\(style?.dropLast(2) ?? "Simple")"),
                        ImagePlaygroundConcept.text("\(weather?.dropLast(2) ?? "Sunny")"),
                        ImagePlaygroundConcept.text("\(pattern?.dropLast(2) ?? "Plain")"),
                        ]) { url in
                    createdImageURL = url
                }
            } else {
                Text("Make sure Apple Intelligence is available to generate outfits!")
            }
            
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
            ZStack {
                Circle()
                    .foregroundStyle(.primary)
                    .frame(width: 33, height: 33)
                
                Circle()
                    .foregroundStyle(color)
                    .frame(width: 30, height: 30)
            }

            Text(label)
        }
        
    }
}

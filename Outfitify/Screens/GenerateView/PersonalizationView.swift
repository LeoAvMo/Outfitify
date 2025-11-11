//
//  PersonalizationView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 09/11/25.
//

import SwiftUI
import UIKit
import ImagePlayground

/*
 Programmatic Approach to IamgePlayground retrieved from:
 https://www.createwithswift.com/generating-images-programmatically-with-image-playground/
 */
struct PersonalizationView: View {
    @State public var clothingType: ClothingType
    @State private var selectedColor: GenerableColor?
    @State private var style: String?
    @State private var weather: String?
    @State private var pattern: String?
    
    
    @State var genImages: [CGImage]?
    @State var genereationStarted: Bool = false
    
    var isTop: String {
        if clothingType == .topwear {
            return "Top"
        } else {
            return clothingType.rawValue
        }
    }
    var body: some View {
        
        
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
            
            
            if let image = genImages  {
                VStack{
                    ForEach(image, id: \.self){ selectedImage in
                        Image(uiImage: UIImage(cgImage: selectedImage))
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                }
            } else {

            }
            
            Button {
                genereationStarted.toggle()
                Task {
                    try await generateImage()
                }
            } label: {
                if genereationStarted {
                    HStack {
                        ProgressView()
                        Text("Generating Clothing...")
                    }
                }
                else {
                    HStack {
                        Image(systemName: "apple.image.playground")
                        Text("Generate clothing")
                    }
                }
            }
              .buttonStyle(.glassProminent)
              .disabled(selectedColor == nil ||
                        style == nil ||
                        weather == nil ||
                        pattern == nil || genereationStarted == true)
        }
    }
    
    func generateImage() async throws {
        do {
            let imageCreator = try await ImageCreator()
            let generationStyle = ImagePlaygroundStyle.animation
            
            let prompt = "A \(selectedColor?.name ?? "Red") \(isTop) in a \(style?.dropLast(2) ?? "basic") style and a \(pattern?.dropLast(2) ?? "plain") pattern for \(weather?.dropLast(2) ?? "sunny") weather"
            print(prompt)
            let images = imageCreator.images(
                for: [.text(prompt)],   //Prompt
                style: generationStyle,
                limit: 1)
            
            for try await image in images {
                if let genImages = genImages {
                    self.genImages = genImages + [image.cgImage]
                }
                else {
                    self.genImages = [image.cgImage]
                }
            }

        }
        catch ImageCreator.Error.notSupported {
            print("Image creation not supported on the current device.")
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



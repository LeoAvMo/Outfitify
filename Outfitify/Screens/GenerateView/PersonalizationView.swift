//
//  PersonalizationView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 09/11/25.
//

import SwiftUI
import UIKit
import ImagePlayground
import SwiftData

/*
 Programmatic Approach to IamgePlayground retrieved from:
 https://www.createwithswift.com/generating-images-programmatically-with-image-playground/
 */
struct PersonalizationView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State public var clothingType: ClothingType
    @State private var selectedColor: GenerableColor?
    @State private var style: String?
    @State private var weather: String?
    @State private var pattern: String?
    
    @State var genImages: [CGImage]?
    @State private var imageData: Data?
    @State var genereationStarted: Bool = false
    @State private var showImage = false
    
    let columns = [GridItem(.fixed(175)), GridItem(.fixed(175))]
    
    var isTop: String {
        if clothingType == .upperwear {
            return "Top"
        } else {
            return clothingType.rawValue
        }
    }
    
    var body: some View {
        
        NavigationStack {
            if let image = genImages  {
                VStack {
                    ForEach(image, id: \.self){ selectedImage in
                        Image(uiImage: UIImage(cgImage: selectedImage))
                            .resizable()
                            .frame(width: 350, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    }
                }
                .navigationBarTitle("Add genereted \(clothingType.rawValue.capitalized)")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add", systemImage: "plus") {
                            guard let clothingData = imageData else { return }
                            let newClothing = Clothing(image: clothingData, clothingType: clothingType)
                            modelContext.insert(newClothing)
                            dismiss()
                        }
                    }
                }
                .transition(.opacity)
            } else {
                LazyVStack {
                    LazyVGrid(columns: columns){
                        NavigationLink {
                            ColorSelectorView(selectedColor: $selectedColor)
                        } label: {
                            ColorSelectorButtonView(generableColor: selectedColor)
                        }
                        
                        NavigationLink {
                            StyleSelectorView(selectable: $style, iterable: styles)
                        } label: {
                            SelectorButtonView(stringToSelect: style, placeholderEmoji: "⚪️", title: "Style")
                        }
                        
                        NavigationLink {
                            StyleSelectorView(selectable: $weather, iterable: weathers)
                        } label: {
                            SelectorButtonView(stringToSelect: weather, placeholderEmoji: "☁️", title: "Weather")
                        }
                        
                        NavigationLink {
                            StyleSelectorView(selectable: $pattern, iterable: patterns)
                        } label: {
                            SelectorButtonView(stringToSelect: pattern, placeholderEmoji: "🏳️", title: "Pattern")
                        }
                    }
                }
                .navigationTitle(Text("Create \(clothingType.rawValue.capitalized)"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Generate", systemImage: "apple.intelligence") {
                            genereationStarted = true
                            Task {
                                try await generateImage()
                            }
                        }
                        .disabled(selectedColor == nil ||
                                  style == nil ||
                                  weather == nil ||
                                  pattern == nil ||
                                  genereationStarted == true)
                        }
                        
                    }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: genImages)
    }
    
    func generateImage() async throws {
        do {
            let imageCreator = try await ImageCreator()
            let generationStyle = ImagePlaygroundStyle.animation
            
            let prompt = "A \(selectedColor?.name ?? "Red") \(isTop) in a \(style?.dropLast(2) ?? "basic") style and a \(pattern?.dropLast(2) ?? "plain") pattern for \(weather?.dropLast(2) ?? "sunny") weather"
            
            let images = imageCreator.images(
                for: [.text(prompt)],   //Prompt
                style: generationStyle,
                limit: 1)
            
            for try await image in images {
                
                let uiImage = UIImage(cgImage: image.cgImage).pngData()
                imageData = uiImage
                
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

struct ColorSelectorButtonView: View {
    public var generableColor: GenerableColor?
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Color")
                .font(.title)
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(LinearGradient(
                        gradient: .init(colors: [.white, .accent.opacity(0.7), .accent.opacity(0.9), .accent]),
                        startPoint: .topLeading,
                          endPoint: .bottomTrailing
                        ))
                VStack{
                    Circle()
                        .foregroundStyle(generableColor?.color ?? .white)
                        .frame(width: 60, height: 60)
                    Text(generableColor?.name.capitalized ?? "None")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .frame(height: 175)
        }
        
    }
}

struct SelectorButtonView: View {
    public var stringToSelect: String?
    public var placeholderEmoji: Character = "⚪️"
    public var title: String
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(LinearGradient(
                        gradient: .init(colors: [.white, .accent.opacity(0.7), .accent.opacity(0.9), .accent]),
                        startPoint: .topLeading,
                          endPoint: .bottomTrailing
                        ))
                VStack{
                    Text(String(stringToSelect?.last ?? placeholderEmoji))
                        .font(.system(size: 60))
                        .frame(width: 70)
                    Text((stringToSelect ?? "None  ").capitalized.dropLast(2))
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
            .frame(height: 175)
        }
        
    }
}

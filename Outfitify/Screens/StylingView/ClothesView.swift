//
//  VisualizerView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI
import SwiftData

struct ClothesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var clothes: [Clothing]
    
    @State private var selectedHeadwear: Clothing? = nil
    @State private var selectedTopwear: Clothing? = nil
    @State private var selectedFootwear: Clothing? = nil
    @State private var selectedLowerwear: Clothing? = nil
    
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 20){
                    ForEach(ClothingType.allCases) { clothing_type in
                        TappableSubtitleView(clothingType: clothing_type, selectedClothing: $selectedHeadwear, clothes: clothes)
                    }
                }
            }
            .toolbar {
                Button("Add", systemImage: "plus"){
                    
                }
            }
        }
        
    }
}

#Preview {
    ClothesView()
        .modelContainer(for: Clothing.self, inMemory: true)
}

struct TappableSubtitleView: View {
    @State public var clothingType: ClothingType
    @Binding var selectedClothing: Clothing?
    
    var clothes: [Clothing]
    
    private var filteredClothes: [Clothing] {
        clothes.filter { $0.clothingType == clothingType }
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
                Text(clothingType.rawValue.capitalized)
                    .font(.title)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.vertical, 1)
            .padding(.horizontal)
            
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(filteredClothes) { clothing in
                        Button {
                            selectedClothing = clothing
                        } label: {
                            ZStack{
                                if let imageData = clothing.image, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    Image("questionmark")
                                        .resizable()
                                        .scaledToFit()
                                }
                                
                                if selectedClothing == clothing {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.sec, lineWidth: 3)
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.sec)
                                }
                            }
                        }
                    }
                    .frame(width: 85, height: 85)
                    .padding(.horizontal)
                    
                    Button {
                        selectedClothing = nil
                    } label: {
                        ZStack {
                            Image(systemName: "xmark")
                                .foregroundStyle(.red)
                                .font(.largeTitle)
                                .bold()
                            if selectedClothing == nil {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.sec, lineWidth: 3)
                            }
                        }
                        .frame(width: 85, height: 85)
                        .padding(.horizontal)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .frame(height: 88)
            Divider()
        }
    }
}



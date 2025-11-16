//
//  OutfitClothesView.swift
//  Outfitify
//
//  Created by Leo A.Molina on 16/11/25.
//

import SwiftUI
import SwiftData

struct OutfitClothesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var clothingType: ClothingType?
    
    @Query private var clothes: [Clothing]
    @Bindable var outfit: Outfit
    
    private var filteredClothes: [Clothing] {
        if clothingType == nil {
            return clothes
        } else {
            return clothes.filter { $0.clothingType == clothingType }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredClothes) { clothing in
                    Button {
                        addRemove(clothing: clothing)
                    } label: {
                        HStack {
                            VStack {
                                if let imageData = clothing.image, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Image(systemName: "questionmark")
                                        .foregroundStyle(.secondary)
                                        .font(.title.bold())
                                }
                            }
                            .frame(width: 75, height: 75)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            HStack {
                                Text(clothing.clothingType.emoji())
                                    .font(.title)
                                Text("\(clothing.clothingType.rawValue.capitalized)")
                                    .font(.title2)
                                Spacer()
                                
                                // Check if clothing's outfits is in the outfit's clothings
                                if outfit.clothes.contains(clothing) {
                                    Image(systemName: "checkmark")
                                        .font(.title2)
                                        .foregroundStyle(.sec)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Clothing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Menu {
                        Button("👗 All Clothes") {
                            clothingType = nil
                        }
                        
                        Button("👒 Headwear") {
                            clothingType = .headwear
                        }
                        Button("👚 Upperwear") {
                            clothingType = .upperwear
                        }
                        Button("👖 Lowerwear") {
                            clothingType = .lowerwear
                        }
                        Button("👟 Footwear") {
                            clothingType = .footwear
                        }
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease")
                    }
                }
                
                
            }
        }
    }
    private func addRemove(clothing: Clothing) {
        if outfit.clothes.contains(clothing) {
            outfit.clothes.removeAll(where: { $0.id == clothing.id })
        } else {
            outfit.clothes.append(clothing)
        }
    }
}

#Preview {
    OutfitClothesView(outfit: Outfit())
}

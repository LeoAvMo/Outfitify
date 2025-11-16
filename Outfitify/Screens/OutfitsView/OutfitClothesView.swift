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
    
    @Query private var clothes: [Clothing]
    @Bindable var outfit: Outfit
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(clothes) { clothing in
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
                                    .font(.title2)
                                Text("\(clothing.clothingType.rawValue.capitalized)")
                                    .font(.title2)
                                Spacer()
                                
                                // Check if clothing's outfits is in the outfit's clothings
                                if outfit.clothes.contains(clothing) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.sec)
                                }
                            }
                        }
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark") {
                        dismiss()
                    }
                }
            }
        }
    }
    func addRemove(clothing: Clothing) {
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

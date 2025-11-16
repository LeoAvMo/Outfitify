//
//  OutfitAccessoriesView.swift
//  Outfitify
//
//  Created by Leo A.Molina on 16/11/25.
//

import SwiftUI
import SwiftData

struct OutfitAccessoriesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var accessories: [Accessory]
    @Bindable var outfit: Outfit
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(accessories) { accessory in
                    Button {
                        addRemove(accessory: accessory)
                    } label: {
                        HStack {
                            VStack {
                                if let imageData = accessory.image, let uiImage = UIImage(data: imageData) {
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
                                Image(systemName: "crown.fill")
                                    .font(.title)
                                Text("Accessory")
                                    .font(.title2)
                                Spacer()
                                
                                // Check if clothing's outfits is in the outfit's clothings
                                if outfit.accessories.contains(accessory) {
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
                
            
                
                
            }
        }
    }
    
    private func addRemove(accessory: Accessory) {
        if outfit.accessories.contains(accessory) {
            outfit.accessories.removeAll(where: { $0.id == accessory.id })
        } else {
            outfit.accessories.append(accessory)
        }
    }
}

#Preview {
    OutfitAccessoriesView(outfit: Outfit())
}

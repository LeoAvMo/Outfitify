//
//  ClothingListView.swift
//  Outfitify
//
//  Created by Leo A.Molina on 16/11/25.
//

import SwiftUI
import SwiftData

struct ClothingListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var clothes: [Clothing]
    @State private var clothingType: ClothingType?
    
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
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button("Close", systemImage: "xmark") {
                        dismiss()
                    }
                }
                
            }
            .navigationTitle(Text("Clothing List"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        
        let itemsToDelete = offsets.compactMap { index -> Clothing? in
            guard filteredClothes.indices.contains(index) else { return nil }
            return filteredClothes[index]
        }
        
        for item in itemsToDelete {
            modelContext.delete(item)
        }
        do {
            try modelContext.save()
        } catch {

            print("Failed to save context after deletion: \(error)")
        }
    }
    
}

#Preview {
    ClothingListView()
}

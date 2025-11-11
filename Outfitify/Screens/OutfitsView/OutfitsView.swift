//
//  OutfitsView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 11/11/25.
//

import SwiftUI
import SwiftData

struct OutfitsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var accessories: [Accessory]
    @Query private var clothes: [Clothing]
    
    var totalOutfits: Int {
        clothes.count
    }
    
    var totalAccessories: Int {
        clothes.count
    }
    
    var totalClothes: Int {
        clothes.count
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    TotalElementsView(total: totalOutfits, label: "Outfits")
                    TotalElementsView(total: totalAccessories, label: "Clothes")
                    TotalElementsView(total: totalAccessories, label: "Accessories")
                }
            }
            .navigationTitle("Outfits")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
        
    }
}

#Preview {
    OutfitsView()
}

struct TotalElementsView: View {
    var total: Int
    var label: String
    
    var body: some View {
        VStack {
            Text(String(total))
                .font(.largeTitle)
                .bold()
            Text(label)
                .font(.caption)
        }
        .frame(width: 100)
    }
}

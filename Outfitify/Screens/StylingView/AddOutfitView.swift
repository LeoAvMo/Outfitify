//
//  AddOutfitView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 07/11/25.
//

import SwiftUI

struct AddOutfitView: View {
    @Environment(\.dismiss) private var dismiss
    @State public var clothingType: ClothingType
    var body: some View {
        NavigationStack{
            Group {
                Button("Take photo") {
                    
                }
                .buttonStyle(.glassProminent)
                
                Button("Choose image from Gallery") {
                    
                }
                .buttonStyle(.glassProminent)
                
            }
            .navigationTitle("Add Outfit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddOutfitView(clothingType: .topwear)
}

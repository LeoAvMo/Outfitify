//
//  OutfitsView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 11/11/25.
//

import SwiftUI

struct OutfitsView: View {
    @State private var totalOutfits: Int = 0
    @State private var totalClothes: Int = 0
    @State private var totalAccessories: Int = 0
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    VStack {
                        Text(String(totalOutfits))
                            .font(.largeTitle)
                            .bold()
                        Text("Outfits")
                            .font(.caption)
                    }
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

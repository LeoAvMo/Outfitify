//
//  GenerateView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 06/11/25.
//

import SwiftUI

struct GenerateView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack(spacing: 30){
                    ClothingTypeButtonView(emoji: "👒", clothingType: "Headwear")
                    ClothingTypeButtonView(emoji: "👕", clothingType: "Upperwear & Full Body")
                    ClothingTypeButtonView(emoji: "👖", clothingType: "Lowerwear")
                    ClothingTypeButtonView(emoji: "👟", clothingType: "Shoes")
                }
                .padding()
            }
            .navigationTitle("Generate")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    GenerateView()
}

struct ClothingTypeButtonView: View {
    var emoji: String
    var clothingType: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 40)
                .stroke(.black, lineWidth: 3)
                .frame(height: 120)
            HStack{
                Text(emoji)
                    .font(.system(size: 60))
                    .frame(width: 70)
                Text(clothingType)
                    .font(.largeTitle)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

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
                    NavigationLink{
                        Text("Hello")
                    } label: {
                        ClothingTypeButtonView(emoji: "👒", clothingType: "Headwear")
                    }
                    
                    NavigationLink{
                        Text("Hello")
                    } label: {
                        ClothingTypeButtonView(emoji: "👕", clothingType: "Upperwear & Full Body")
                    }
                    
                    NavigationLink{
                        Text("Hello")
                    } label: {
                        ClothingTypeButtonView(emoji: "👖", clothingType: "Lowerwear")
                    }
                    
                    NavigationLink{
                        Text("Hello")
                    } label: {
                        ClothingTypeButtonView(emoji: "👟", clothingType: "Footwear")
                    }
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
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .stroke(.black, lineWidth: 3)
            HStack{
                Text(emoji)
                    .font(.system(size: 60))
                    .frame(width: 70)
                Text(clothingType)
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .frame(height: 120)
    }
}

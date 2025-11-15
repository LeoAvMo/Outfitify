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
                LazyVStack(spacing: 25) {
                    
                    ForEach(ClothingType.allCases) { clothType in
                        NavigationLink{
                            PersonalizationView(clothingType: clothType)
                        } label: {
                            ClothingTypeButtonView(emoji: clothType.emoji(), clothingType: clothType.rawValue)
                        }
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
    @Environment(\.colorScheme) var colorScheme
    
    var emoji: String
    var clothingType: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 3)
            HStack{
                Text(emoji)
                    .font(.system(size: 60))
                    .frame(width: 70)
                Text(clothingType.capitalized)
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .frame(height: 120)
    }
}

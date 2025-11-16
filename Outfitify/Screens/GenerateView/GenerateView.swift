//
//  GenerateView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 06/11/25.
//

import SwiftUI

struct GenerateView: View {
    let columns = [GridItem(.fixed(175)), GridItem(.fixed(175))]
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack {
                    ContentUnavailableView("Create your Clothes", systemImage: "apple.intelligence", description: Text("Generate your outfits by parts using AI and customize them with your personal style!"))
                    
                    LazyVGrid(columns: columns) {
                        ForEach(ClothingType.allCases) { clothType in
                            NavigationLink{
                                PersonalizationView(clothingType: clothType)
                            } label: {
                                
                                ClothingTypeButtonView(emoji: clothType.emoji(), clothingType: clothType.rawValue)
                            }
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
    var emoji: String
    var clothingType: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(LinearGradient(
                    gradient: .init(colors: [.accent.opacity(0.5), .accent, .sec, .sec.opacity(0.5)]),
                    startPoint: .topLeading,
                      endPoint: .bottomTrailing
                    ))
            VStack{
                Text(emoji)
                    .font(.system(size: 60))
                    .frame(width: 70)
                Text(clothingType.capitalized)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)
            
        }
        .frame(height: 175)
    }
}

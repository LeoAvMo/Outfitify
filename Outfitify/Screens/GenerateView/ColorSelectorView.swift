//
//  ColorSelectorView.swift
//  Outfitify
//
//  Created by Leo A.Molina on 16/11/25.
//

import SwiftUI

struct ColorSelectorView: View {
    @Environment(\.dismiss) private var dismiss
    let columns = [GridItem(.fixed(175)), GridItem(.fixed(175))]
    @Binding var selectedColor: GenerableColor?
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(generableColors, id: \.self) { color in
                        Button {
                            selectedColor = color
                            dismiss()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(LinearGradient(
                                        gradient: .init(colors: [.white, .accent.opacity(0.7), .accent.opacity(0.9), .accent]),
                                        startPoint: .topLeading,
                                          endPoint: .bottomTrailing
                                        ))
                                    .overlay(alignment: .topTrailing) {
                                        if selectedColor == color {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(.sec)
                                                .font(.largeTitle)
                                                .padding(.horizontal, 9)
                                                .padding(.vertical, 9)
                                        }
                                    }
                                VStack {
                                        Circle()
                                            .foregroundStyle(color.color)
                                            .frame(width: 60, height: 60)
                                    
                                    
                                    Text(color.name)
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
                }
            }
            .navigationTitle("Color")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

#Preview {
    ColorSelectorView(selectedColor: .constant(GenerableColor(name: "Red", color: .red)))
}

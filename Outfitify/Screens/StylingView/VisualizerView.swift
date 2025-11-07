//
//  VisualizerView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI

struct VisualizerView: View {
    @Binding var showAddView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
        }
        .toolbar {
            Button("Share", systemImage: "square.and.arrow.up"){
            }
            Button("Save", systemImage: "square.and.arrow.down"){
                
            }
        }
    }
}

#Preview {
    VisualizerView(showAddView: .constant(false))
}


struct TappableSubtitleView: View {
    @State public var clothingType: ClothingType
    @Binding var showAddView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            HStack{
                Text(clothingType.rawValue)
                    .font(.title)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                Spacer()
                Button("Add", systemImage: "plus") {
                    // Returh the view and show sheet
                    // showedView = 
                    showAddView.toggle()
                }
                .buttonStyle(.glassProminent)
            }
            
            ScrollView(.horizontal) {
                LazyHStack{
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .frame(width: 85, height: 85)
                        .padding(.horizontal, 3)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.black, lineWidth: 2)
                        Image("placeholderDress")
                            .resizable()
                            .scaledToFit()
                            
                    }
                    .frame(width: 85, height: 85)
                    .padding(.horizontal, 3)
                }
            }
            .scrollIndicators(.hidden)
            
            
        }
        
        
        
    }
}

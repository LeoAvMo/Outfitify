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
        VStack(alignment: .leading){
            // MARK: Headwear ScrollView
            Button {
                showAddView.toggle()
            } label: {
                TappableSubtitleView(text: "Headwear")
            }
            .buttonStyle(.plain)
            
            ScrollView(.horizontal) {
                LazyHStack{
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
            
            // MARK: Tops ScrollView
            Button {
                showAddView.toggle()
            } label: {
                TappableSubtitleView(text: "Upperwear & Full Body")
            }
            .buttonStyle(.plain)
            ScrollView(.horizontal) {
                LazyHStack{
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
            
            Button {
                showAddView.toggle()
            } label: {
                TappableSubtitleView(text: "Lowerwear")
            }
            .buttonStyle(.plain)
            ScrollView(.horizontal) {
                LazyHStack{
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)

                }
            }
            
            Button {
                showAddView.toggle()
            } label: {
                TappableSubtitleView(text: "Shoes")
            }
            .buttonStyle(.plain)
            ScrollView(.horizontal) {
                LazyHStack{
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
            
        }
    }
}

#Preview {
    VisualizerView(showAddView: .constant(false))
}


struct TappableSubtitleView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundStyle(.primary)
            .fontWeight(.semibold)
        
        Image(systemName: "plus")
            .font(.title2)
            .foregroundStyle(.accent)
            .fontWeight(.semibold)
    }
}

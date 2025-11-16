//
//  OutfitDetailView.swift
//  Outfitify
//
//  Created by Leo A.Molina on 16/11/25.
//

import SwiftUI

struct OutfitDetailView: View {
    @Bindable var outfit: Outfit
    
    private var image: Image? {
        if let imageData = outfit.image, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return nil
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                image?
                    .resizable()
                    .scaledToFill()
                
            }
            .toolbar {
                
                Button("Delete", systemImage: "trash"){
                    
                }
                
                ShareLink(item: image ?? Image("placeholderClothing"), preview: SharePreview("Outfitify", image: image ?? Image("placeholderClothing"))) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
            
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button("Details", systemImage: "ellipsis"){
                        
                    }
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .ignoresSafeArea(.all)
            .frame(minWidth: 0)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    OutfitDetailView(outfit: Outfit())
}

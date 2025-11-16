//
//  OutfitDetailView.swift
//  Outfitify
//
//  Created by Leo A.Molina on 16/11/25.
//

import SwiftUI
import SwiftData

struct OutfitDetailView: View {
    @Bindable var outfit: Outfit
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var showAccessoriesView: Bool = false
    @State private var showClothesView: Bool = false
    @State private var showAlert = false
    
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
                    showAlert.toggle()
                }
                
                ShareLink(item: image ?? Image("placeholderClothing"), preview: SharePreview("Outfitify", image: image ?? Image("placeholderClothing"))) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
            
            .toolbar{
                ToolbarItem(placement: .bottomBar) {
                    Button("Clothing", systemImage: "crown"){
                        showAccessoriesView.toggle()
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Accessories", systemImage: "hanger"){
                        showClothesView.toggle()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Outfit"),
                    message: Text("Are you sure you want to delete this Outfit? Deleted Outfits cannot be restored."),
                    primaryButton: .default(
                        Text("Cancel")
                    ),
                    secondaryButton: .destructive(
                        Text("Delete"),
                        action: deleteOutfit
                    )
                )
            }
            .sheet(isPresented: $showAccessoriesView) {
                OutfitAccessoriesView()
            }
            .sheet(isPresented: $showClothesView) {
                OutfitClothesView(outfit: outfit)
            }
            .toolbar(.hidden, for: .tabBar)
            .ignoresSafeArea(.all)
            .frame(minWidth: 0)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func deleteOutfit() {
        modelContext.delete(outfit)
        dismiss()
    }
}

#Preview {
    OutfitDetailView(outfit: Outfit())
}

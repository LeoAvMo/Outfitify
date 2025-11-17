//
//  VisualizerView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI
import SwiftData

struct ClothesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var clothes: [Clothing]
    
    @State private var selectedHeadwear: Clothing? = nil
    @State private var selectedTopwear: Clothing? = nil
    @State private var selectedFootwear: Clothing? = nil
    @State private var selectedLowerwear: Clothing? = nil
    @State private var showListView: Bool = false
    @State private var clothingTypeToAdd: ClothingType? = nil
    @State private var newOutfitData: Data?
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 20){
                    
                    TappableSubtitleView(clothingType: .headwear, selectedClothing: $selectedHeadwear, clothes: clothes)
                    TappableSubtitleView(clothingType: .upperwear, selectedClothing: $selectedTopwear, clothes: clothes)
                    TappableSubtitleView(clothingType: .lowerwear, selectedClothing: $selectedLowerwear, clothes: clothes)
                    TappableSubtitleView(clothingType: .footwear, selectedClothing: $selectedFootwear, clothes: clothes)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Outfit saved successfully"), message: Text("You've successfully added a new outfit. Go to your wardrobe to see it!"), dismissButton: Alert.Button.default(Text("OK")))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit", systemImage: "list.bullet") {
                        showListView.toggle()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("👒 Add Headwear") {
                            clothingTypeToAdd = .headwear
                        }
                        Button("👚 Add Upperwear") {
                            clothingTypeToAdd = .upperwear
                        }
                        Button("👖 Add Lowerwear") {
                            clothingTypeToAdd = .lowerwear
                        }
                        Button("👟 Add Footwear") {
                            clothingTypeToAdd = .footwear
                        }
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Arrange", systemImage: "cabinet.fill") {
                        saveOutfit()
                        showAlert.toggle()
                    }
                }
            }
            .sheet(item: $clothingTypeToAdd) { selectedType in
                AddClothingView(clothingType: selectedType)
            }
            .sheet(isPresented: $showListView) {
                ClothingListView()
            }
        }
    }
    private func saveOutfit() {
        let newOutfitView = ArrangedOutfitView(head: selectedHeadwear, upper: selectedTopwear, lower: selectedLowerwear, foot: selectedFootwear)
        let outfitImage = newOutfitView.snapshot()
        
        guard let outfitImageData = outfitImage.pngData() else {
            return
        }
        
        let newOutfit = Outfit(image: outfitImageData)
        let clothesToAdd = [selectedHeadwear, selectedTopwear, selectedLowerwear, selectedFootwear].compactMap { $0 }
        newOutfit.clothes.append(contentsOf: clothesToAdd)
        
        modelContext.insert(newOutfit)
        
    }
}

#Preview {
    ClothesView()
        .modelContainer(for: Clothing.self, inMemory: true)
}

struct TappableSubtitleView: View {
    @State public var clothingType: ClothingType
    @Binding var selectedClothing: Clothing?
    
    var clothes: [Clothing]
    
    private var filteredClothes: [Clothing] {
        clothes.filter { $0.clothingType == clothingType }
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
                Text(clothingType.rawValue.capitalized)
                    .font(.title)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.vertical, 1)
            .padding(.horizontal)
            
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(filteredClothes) { clothing in
                        Button {
                            selectedClothing = clothing
                        } label: {
                            ZStack{
                                if let imageData = clothing.image, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    Image("questionmark")
                                        .resizable()
                                        .scaledToFit()
                                }
                                
                                if selectedClothing == clothing {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.sec, lineWidth: 3)
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.sec)
                                }
                            }
                        }
                    }
                    .frame(width: 85, height: 85)
                    .padding(.horizontal)
                    
                    Button {
                        selectedClothing = nil
                    } label: {
                        ZStack {
                            Image(systemName: "xmark")
                                .foregroundStyle(.red)
                                .font(.largeTitle)
                                .bold()
                            if selectedClothing == nil {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.sec, lineWidth: 3)
                            }
                        }
                        .frame(width: 85, height: 85)
                        .padding(.horizontal)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .frame(height: 88)
            Divider()
        }
        .onAppear {
            selectedClothing = filteredClothes.first
        }
    }
}



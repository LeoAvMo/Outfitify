//
//  VisualizerView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI
import SwiftData

struct ClothesView: View {
    @Binding var showAddView: Bool
    @State private var selectedHeadwear: Clothing? = nil
    @State private var selectedTopwear: Clothing? = nil
    @State private var selectedFootwear: Clothing? = nil
    @State private var selectedLowerwear: Clothing? = nil
    
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading, spacing: 20){
                TappableSubtitleView(clothingType: .headwear, showAddView: $showAddView, selectedClothing: $selectedHeadwear)
                TappableSubtitleView(clothingType: .topwear, showAddView: $showAddView, selectedClothing: $selectedTopwear)
                TappableSubtitleView(clothingType: .lowerwear, showAddView: $showAddView, selectedClothing: $selectedLowerwear)
                TappableSubtitleView(clothingType: .footwear, showAddView: $showAddView, selectedClothing: $selectedFootwear)
            }
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
    ClothesView(showAddView: .constant(false))
        .modelContainer(for: Clothing.self, inMemory: true)
}

struct TappableSubtitleView: View {
    var clothingType: ClothingType
    @Binding var showAddView: Bool
    @Binding var selectedClothing: Clothing?
    
    @Environment(\.modelContext) private var modelContext
    @Query private var clothes: [Clothing]
    
    init(clothingType: ClothingType, showAddView: Binding<Bool>, selectedClothing: Binding<Clothing?>) {
        
        self.clothingType = clothingType
        
        self._showAddView = showAddView
        self._selectedClothing = selectedClothing
        
        let typeRawValue = clothingType.rawValue
        let predicate = #Predicate<Clothing> { $0.clothingType == typeRawValue }
        self._clothes = Query(filter: predicate)
    }
    
    var body: some View {
        
            VStack(alignment: .leading) {
                HStack{
                    Text(clothingType.rawValue)
                        .font(.title)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                    Spacer()
                    Button {
                        showAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                    .buttonStyle(.glassProminent)
                    
                }
                .padding(.vertical, 1)
                .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(clothes) { clothing in
                            Button {
                                selectedClothing = clothing
                            } label: {
                                ZStack{
                                    // TODO: change it to accept the data type for the Clothing
                                    Image("placeholderClothing")
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    if selectedClothing == clothing {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.accent, lineWidth: 3)
                                        Image(systemName: "checkmark.circle.fill")
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
            }
        
        .sheet(isPresented: $showAddView) {
            AddOutfitView(clothingType: clothingType)
        }
    }
}

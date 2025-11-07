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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            TappableSubtitleView(clothingType: .headwear, showAddView: $showAddView)
            TappableSubtitleView(clothingType: .topwear, showAddView: $showAddView)
            TappableSubtitleView(clothingType: .lowerwear, showAddView: $showAddView)
            TappableSubtitleView(clothingType: .footwear, showAddView: $showAddView)
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
    let clothingType: ClothingType
    @Binding var showAddView: Bool

    @Query private var clothes: [Clothing]
        
    init(clothingType: ClothingType, showAddView: Binding<Bool>) {
        self.clothingType = clothingType
        self._showAddView = showAddView
        
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
                    /*
                     For clothing in clothes, get the image and
                     */
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.accent, lineWidth: 3)
                        Image("placeholderDress")
                            .resizable()
                            .scaledToFit()
                        
                    }
                    .frame(width: 85, height: 85)
                    .padding(.horizontal)
                   
                    Image(systemName: "xmark")
                        .foregroundStyle(.red)
                        .font(.largeTitle)
                        .frame(width: 85, height: 85)
                        .padding(.horizontal)
                        .bold()
                }
            }
            .scrollIndicators(.hidden)
            .frame(height: 88)
        }
        .sheet(isPresented: $showAddView) {
            AddOutfitView(clothingType: clothingType)
                .presentationDetents([.medium])
        }
    }
}

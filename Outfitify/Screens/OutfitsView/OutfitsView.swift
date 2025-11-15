//
//  OutfitsView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 11/11/25.
//

import SwiftUI
import SwiftData

struct OutfitsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var outfits: [Outfit]
    @Query private var accessories: [Accessory]
    @Query private var clothes: [Clothing]
    @Query private var dayFits: [DayFit]
    @State private var showSheet: Bool = false
    
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    var totalOutfits: Int {
        outfits.count
    }
    
    var totalClothes: Int {
        clothes.count
    }
    
    var totalAccessories: Int {
        accessories.count
    }
    
    var totalDayFits: Int {
        dayFits.count
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack{
                        Text("Wardrobe")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .offset(y: 15)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundStyle(.accent)
                        HStack {
                            TotalElementsView(total: totalOutfits, label: "Outfits")
                            TotalElementsView(total: totalClothes, label: "Clothes")
                            TotalElementsView(total: totalAccessories, label: "Accessories")
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .foregroundStyle(.orange)
                        HStack {
                            Image(systemName: "flame.fill")
                                .resizable()
                                .frame(width: 70, height: 87)
                                .bold()
                                
                            VStack {
                                Text("\(totalDayFits)")
                                    .font(.largeTitle)
                                    .bold()
                                Text("Days you've")
                                    .multilineTextAlignment(.center)
                                Text("looked **Fantastic!**")
                                    .font(.title3)
                            }
                            .padding()
                            
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 150)
                    
                    HStack{
                        Text("Outfits")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .offset(y:15)
                    
                    if outfits.isEmpty {
                        ContentUnavailableView("No Outfits", systemImage: "cabinet.fill", description: Text("Start matching new outfits to see them here!"))
                    } else {
                        LazyVGrid(columns: columns) {
                            ForEach(outfits) { outfit in
                                if let imageData = outfit.image, let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 182)
                                        .clipShape(RoundedRectangle(cornerRadius: 40))
                                        
                                } else {
                                    Image(systemName: "questionmark.circle")
                                        .resizable()
                                        .scaledToFill()
                                        .foregroundStyle(Color.gray)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Outfit", systemImage: "plus") {
                        showSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddOutfitView()
            }
            .navigationTitle("Outfits")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    OutfitsView()
}

struct TotalElementsView: View {
    var total: Int
    var label: String
    
    var body: some View {
        VStack {
            Text(String(total))
                .font(.largeTitle)
                .bold()
            Text(label)
                .font(.caption)
        }
        .frame(width: 100)
    }
}

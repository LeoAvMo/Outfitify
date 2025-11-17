//
//  AccessoriesView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 07/11/25.
//

import SwiftUI
import SwiftData

struct AccessoriesView: View {
    @Environment(\.modelContext) private var modelContext
    let columns: [GridItem] = [GridItem(.fixed(120)),GridItem(.fixed(120)),GridItem(.fixed(120))]
    @Query private var accessories: [Accessory]
    @State private var showSheet: Bool = false
    @State private var showAccessoriesList: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Accessories")
                        .font(.title)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.horizontal)
                if accessories.isEmpty {
                    VStack {
                        
                        ContentUnavailableView("No Acccesories found", systemImage: "crown.fill", description: Text("It looks like there are no accessories to display. Add a new accessory to get started!"))
                        
                    }
                    
                } else {
                    LazyVGrid(columns: columns) {
                        
                        ForEach(accessories) { accessory in
                            NavigationLink {
                                AccessoryDetailView(accessory: accessory)
                            } label: {
                                ZStack{
                                    if let imageData = accessory.image, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .clipShape(RoundedRectangle(cornerRadius: 18))
                                    } else {
                                        Image("placeholderAccessory")
                                            .resizable()
                                            .clipShape(RoundedRectangle(cornerRadius: 18))
                                    }
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color("secColor"), lineWidth: 3)
                                }
                                .frame(height: 120)
                            }
                            
                        }
                    }
                }
                
                
            }
            .sheet(isPresented: $showSheet) {
                AddAccessoryView()
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus"){
                        showSheet.toggle()
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    AccessoriesView()
}


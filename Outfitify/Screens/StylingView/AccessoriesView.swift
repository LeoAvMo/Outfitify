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
    @Binding var showSheet: Bool
    @Query private var accessories: [Accessory]
    
    var body: some View {
        
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
                            EditAccessoryView(accessoryToEdit: accessory)
                        } label: {
                            ZStack{
                                Image(accessory.image)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
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

#Preview {
    AccessoriesView(showSheet: .constant(false))
}


struct AddAccessoryView: View {
    var body: some View {
        Text("Add accessory")
    }
}

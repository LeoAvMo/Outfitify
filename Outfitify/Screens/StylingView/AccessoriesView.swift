//
//  AccessoriesView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 07/11/25.
//

import SwiftUI

struct AccessoriesView: View {
    let columns: [GridItem] = [GridItem(.fixed(120)),GridItem(.fixed(120)),GridItem(.fixed(120))]
    var body: some View {
        NavigationStack{
            ScrollView {
                HStack {
                    Text("Accessories")
                        .font(.title)
                        .foregroundStyle(.primary)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.horizontal)
                
                LazyVGrid(columns: columns) {
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color("secColor"), lineWidth: 2)
                            .frame(height: 120)
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "plus"){
                        
                    }
                }
            }
        }
        
    }
}

#Preview {
    AccessoriesView()
}

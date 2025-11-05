//
//  OutfitTabView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI

struct OutfitTabView: View {
    var body: some View {
        TabView{
            
            Tab("Planner", systemImage: "calendar") {
                
            }
            
            Tab ("Styling", systemImage: "sparkles"){
                
            }
            
            Tab("Wardrobe", systemImage: "cabinet.fill") {
                
            }
            
        }
    }
}

#Preview {
    OutfitTabView()
}

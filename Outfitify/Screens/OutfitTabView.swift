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
            
            Tab("Generate", systemImage: "sparkles"){
                GenerateView()
            }
            
            Tab("My Week", systemImage: "calendar") {
                MyWeekView()
            }
            
            Tab ("Match", systemImage: "hanger"){
                MatchView()
            }
            
            Tab("Outfits", systemImage: "tshirt") {
                
            }
            
        }
    }
}

#Preview {
    OutfitTabView()
}

//
//  ArrangedOutfitView.swift
//  Outfitify
//
//  Created by Leo A.Molina on 16/11/25.
//

import SwiftUI

struct ArrangedOutfitView: View {
    @State public var head: Clothing?
    @State public var upper: Clothing?
    @State public var lower: Clothing?
    @State public var foot: Clothing?
    
    var body: some View {
        VStack{
            
            if let imageData = head?.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            }
            
            if let imageData = upper?.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            
            if let imageData = lower?.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
            }
            
            if let imageData = foot?.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
        }
        .scaledToFit()
        .frame(width: 300, height: 400)
        .background(.white)
    }
}

#Preview {
    ArrangedOutfitView()
}

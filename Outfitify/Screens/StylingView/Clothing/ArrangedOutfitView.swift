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
                    .frame(width: 250, height: 250)
            }
            
            if let imageData = upper?.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
            }
            
            if let imageData = lower?.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 500)
            }
            
            if let imageData = foot?.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .scaledToFit()
        .frame(width: 1200, height: 1600)
    }
}

#Preview {
    ArrangedOutfitView()
}

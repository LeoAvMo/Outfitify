//
//  AddOutfitView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 07/11/25.
//

import SwiftUI
import PhotosUI
import CoreTransferable

struct AddOutfitView: View {
    @Environment(\.dismiss) private var dismiss
    @State public var clothingType: ClothingType
    
    @State private var imageSelection: PhotosPickerItem?
    @State private var image: Image?
    @State private var selectedImageData: Data?
    
    
    var body: some View {
        NavigationStack {
            Group {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.accent, lineWidth: 5)
                        .fill(.background)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                        
                }
                .frame(width: 300, height: 300)
                .task(id: imageSelection) {
                    image = try? await imageSelection?
                        .loadTransferable(type: Image.self)
                }
                
                VStack {
                    PhotosPicker(selection: $imageSelection, matching: .images, photoLibrary: .shared()) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Choose image from Gallery")
                        }
                        .font(.title2)
                        .padding(7)
                        .frame(maxWidth: .infinity)
                        .bold()
                    }
                    .buttonStyle(.glassProminent)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Take a Photo")
                        }
                        .font(.title2)
                        .padding(7)
                        .frame(maxWidth: .infinity)
                        .bold()
                    }
                    
                    .buttonStyle(.glass)
                }
                
                
            }
            .padding(.horizontal)
            .navigationTitle("Add Outfit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
        
}

#Preview {
    AddOutfitView(clothingType: .topwear)
}



enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}

enum TransferError: Error {
    case importFailed
}





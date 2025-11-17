//
//  EditAccessoryView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 08/11/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddAccessoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
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
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        
                }
                .frame(width: 300, height: 300)
                .task(id: imageSelection) {
                    image = try? await imageSelection?
                        .loadTransferable(type: Image.self)
                    
                    selectedImageData = try? await imageSelection?
                            .loadTransferable(type: Data.self)
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
                    
                    // TODO: Make Camera work
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
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", systemImage: "xmark") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add", systemImage: "checkmark") {
                            
                            guard let imageData = selectedImageData else { return }
                            let newAccessory = Accessory(image: imageData)
                            modelContext.insert(newAccessory)
                            dismiss()
                        }
                        .disabled(image == nil || selectedImageData == nil)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Add Accessory")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    AddAccessoryView()
}

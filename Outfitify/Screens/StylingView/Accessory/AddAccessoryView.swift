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
                    image = nil
                    selectedImageData = nil
                    
                    do {
                        // 1. Load initial data from the picker
                        guard let originalData = try await imageSelection?.loadTransferable(type: Data.self) else { return }
                        
                        // 2. Convert Data to UIImage
                        guard let originalUIImage = UIImage(data: originalData) else {
                            print("Failed to create UIImage from data")
                            return
                        }
                        
                        // 3. Call the async removeBackground function
                        guard let processedUIImage = await removeBackground(from: originalUIImage) else {
                            print("Failed to remove background")
                            return // Fails, so image/data remain nil, "Add" button remains disabled
                        }
                        
                        // 4. Convert processed UIImage back to Data (PNG for transparency)
                        guard let processedData = processedUIImage.pngData() else {
                            print("Failed to convert processed UIImage to PNG data")
                            return // Fails, so image/data remain nil
                        }
                        
                        // 5. Success! Store the new Data and displayable Image
                        selectedImageData = processedData
                        image = Image(uiImage: processedUIImage)
                        
                    } catch {
                        print("Error loading image: \(error)")
                        // On error, image/data remain nil
                    }
                    /*
                    image = try? await imageSelection?
                        .loadTransferable(type: Image.self)
                    
                    selectedImageData = try? await imageSelection?
                            .loadTransferable(type: Data.self)
                     */
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

//
//  AddDayFit.swift
//  Outfitify
//
//  Created by Leo A.Molina on 14/11/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddDayFit: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var imageSelection: PhotosPickerItem?
    @State private var image: Image?
    @State private var selectedImageData: Data?
    @State public var date: Date
    
    var body: some View {
        NavigationStack {
            Group {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.accent, lineWidth: 5)
                        .fill(.background)
                    
                    image?
                        .resizable()
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
                            
                            guard let myFitData = selectedImageData else { return }
                            let newDayFit = DayFit(date: date, image: myFitData)
                            modelContext.insert(newDayFit)
                            dismiss()
                        }
                        .disabled(image == nil || selectedImageData == nil)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Add Fit for \(date.formatted(date: .numeric, time: .omitted))")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddDayFit(date: Date.now)
}

//
//  AccessoryDetailView.swift
//  Outfitify
//
//  Created by Leo A.Molina on 17/11/25.
//

import SwiftUI
import SwiftData

struct AccessoryDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var accessory: Accessory
    @State private var showAlert: Bool = false
    var body: some View {
        NavigationStack {
            VStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.accent, lineWidth: 5)
                        .fill(.background)
                    
                    if let imageData = accessory.image, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                }
                .frame(width: 300, height: 300)
                }
            }
            .navigationTitle(Text("Accessory Detail"))
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Accessory"),
                    message: Text("Are you sure you want to delete this Accessory? Deleted accessories cannot be restored."),
                    primaryButton: .default(
                        Text("Cancel")
                    ),
                    secondaryButton: .destructive(
                        Text("Delete"),
                        action: deleteAccessory
                    )
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Delete", systemImage: "trash") {
                        showAlert.toggle()
                }
            }
        }
    }
    private func deleteAccessory() {
        withAnimation {
            modelContext.delete(accessory)
            dismiss()
        }
    }
}

#Preview {
    AccessoryDetailView(accessory: Accessory())
}

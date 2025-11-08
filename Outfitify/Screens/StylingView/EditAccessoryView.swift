//
//  EditAccessoryView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 08/11/25.
//

import SwiftUI

struct EditAccessoryView: View {
    let accessoryToEdit: Accessory

    var body: some View {
        NavigationStack {
            // Build your editing UI here, mutating accessoryToEdit's properties directly as needed.
            // For example:
            // TextField("Image name", text: $accessoryToEdit.image)
            // Note: For @Model classes, you can mutate properties directly in controls that support bindings to reference types.
            EmptyView()
        }
    }
}

#Preview {
    EditAccessoryView(accessoryToEdit: Accessory())
}

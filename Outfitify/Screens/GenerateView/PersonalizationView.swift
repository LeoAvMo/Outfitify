//
//  PersonalizationView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 09/11/25.
//

import SwiftUI


struct PersonalizationView: View {
    @State public var clothingType: ClothingType
    @State private var color: Color = .red
    var body: some View {
        NavigationStack {
            Form {
                Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Color")) {
                    /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                    /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                }
                .pickerStyle(.inline)
            }
            .navigationTitle(Text("Create \(clothingType.rawValue)"))
        }
    }
}

#Preview {
    PersonalizationView(clothingType: .headwear)
}

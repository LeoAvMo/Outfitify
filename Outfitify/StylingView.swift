//
//  StylingView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI

enum DisplayedStylingView: String, CaseIterable, Equatable, Identifiable {
    case visualizer = "Visualizer"
    case canvas = "Canvas"
    
    var id: Self { self }
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

struct StylingView: View {
    @State private var displayedView: DisplayedStylingView = .visualizer
    var body: some View {
        NavigationStack {
            Group {
                Picker("Display", selection: $displayedView) {
                    ForEach(DisplayedStylingView.allCases) { display in
                        Text(display.localizedName).tag(display)
                    }
                }
                .pickerStyle(.segmented)
            }
            .navigationTitle("Styling")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Items", systemImage: "plus") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    StylingView()
}

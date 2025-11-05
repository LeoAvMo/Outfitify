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

struct MatchView: View {
    @State private var displayedView: DisplayedStylingView = .visualizer
    @State private var showAddView: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                Picker("Display", selection: $displayedView) {
                    ForEach(DisplayedStylingView.allCases) { display in
                        Text(display.localizedName).tag(display)
                    }
                }
                .pickerStyle(.segmented)
                
                switch displayedView {
                case .visualizer:
                    VisualizerView(showAddView: $showAddView)
                case .canvas:
                    Spacer()
                    Text("Canvas View")
                    Spacer()
                }
                
            }
            
            .navigationTitle("Match")
            .navigationBarTitleDisplayMode(.inline)
            
            .sheet(isPresented: $showAddView) {
                Text("Hello")
            }
        }
    }
}

#Preview {
    MatchView()
}

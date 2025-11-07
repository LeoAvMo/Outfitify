//
//  StylingView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI



struct MatchView: View {
    @State private var displayedView: DisplayedStylingView = .clothes
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
                case .clothes:
                    ClothesView(showAddView: $showAddView)
                        .padding(.top)
                    Spacer()
                case .accessories:
                    Spacer()
                    AccessoriesView()
                    Spacer()
                }
            }
            .navigationTitle("Match")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
}

#Preview {
    MatchView()
}

enum DisplayedStylingView: String, CaseIterable, Equatable, Identifiable {
    case clothes = "Clothes"
    case accessories = "Accessories"
    
    var id: Self { self }
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

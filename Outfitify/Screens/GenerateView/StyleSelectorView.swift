//
//  StyleSelectorView.swift
//  Outfitify
//
//  Created by Leo A.Molina on 16/11/25.
//

import SwiftUI

struct StyleSelectorView: View {
    @Environment(\.dismiss) private var dismiss
    let columns = [GridItem(.fixed(175)), GridItem(.fixed(175))]
    @Binding var selectable: String?
    @State public var iterable: [String]
    @State public var navTitle: String = "Select Style"
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(iterable, id: \.self) { selection in
                        Button {
                            selectable = selection
                            dismiss()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(LinearGradient(
                                        gradient: .init(colors: [.white, .accent.opacity(0.7), .accent.opacity(0.9), .accent]),
                                        startPoint: .topLeading,
                                          endPoint: .bottomTrailing
                                        ))
                                    .overlay(alignment: .topTrailing) {
                                        if selectable == selection {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(.sec)
                                                .font(.largeTitle)
                                                .padding(.horizontal, 9)
                                                .padding(.vertical, 9)
                                        }
                                    }
                                VStack {
                                    
                                    Text(String(selection.last ?? "?"))
                                        .font(.system(size: 60))
                                        .frame(width: 70)
                                    
                                    Text(String(selection.dropLast(2)))
                                        .font(.title)
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.black)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal)
                                
                            }
                            .frame(height: 175)
                        }
                        
                    }
                }
            }
            .navigationTitle(navTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    StyleSelectorView(selectable: .constant(nil), iterable: styles)
}

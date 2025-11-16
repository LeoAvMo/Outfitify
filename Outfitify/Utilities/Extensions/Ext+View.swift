//
//  Ext+View.swift
//  Outfitify
//
//  Created by Leo A.Molina on 16/11/25.
//

import SwiftUI

extension View {
    @MainActor
    func snapshot() -> UIImage {
        let renderer = ImageRenderer(content: self)
        return renderer.uiImage!
    }
}

//
//  OutfitifyApp.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI
import SwiftData

@main
struct OutfitifyApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Outfit.self, DayFit.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            OutfitTabView()
            
        }
        .modelContainer(sharedModelContainer)
    }
}

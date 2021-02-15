//
//  nelsonApp.swift
//  Shared
//
//  Created by Luke Bettridge on 15/02/2021.
//

import SwiftUI

@main
struct nelsonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

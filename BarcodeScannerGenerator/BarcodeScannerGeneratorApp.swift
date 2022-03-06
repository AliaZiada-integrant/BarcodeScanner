//
//  BarcodeScannerGeneratorApp.swift
//  BarcodeScannerGenerator
//
//  Created by Alia Ziada on 06/03/2022.
//

import SwiftUI

@main
struct BarcodeScannerGeneratorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

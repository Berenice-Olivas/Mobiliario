//
//  vigaApp.swift
//  
//
//  Created by Berenice Olivas
//

import SwiftUI

@main
struct mobiliarioApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager() )

        }
    }
}

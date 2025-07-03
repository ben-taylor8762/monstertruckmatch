//
//  MonsterTruckMatchApp.swift
//  MonsterTruckMatch
//
//  Created by Ben Taylor on 7/2/25.
//

import SwiftUI

@main
struct MonsterTruckMatchApp: App {
    @State private var game = Game()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(game)
        }
    }
}

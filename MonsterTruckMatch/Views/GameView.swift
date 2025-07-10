//
//  GameView.swift
//  MatchingGame
//
//  Created by Ben Taylor on 5/3/25.
//

import SwiftUI

struct GameView: View {
    @Environment(Game.self) private var game

    var body: some View {
        ZStack {
            GridView()
            if game.tileCorrectCount == game.getTileCount() {
                CongratsView()
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    GameView()
        .environment(Game())
    
}

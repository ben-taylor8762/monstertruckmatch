//
//  CongratsView.swift
//  MatchingGame
//
//  Created by Ben Taylor on 5/19/25.
//

import SwiftUI

struct CongratsView: View {
    @Environment(Game.self) private var game
    
    var body: some View {
        VStack {
            Text("Congrats, you win!!!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .background(.white)
                .foregroundColor(.red)
                .cornerRadius(12)
                .shadow(radius: 10)
                .transition(.scale)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            game.hasWon = true
                            game.canFlip = true
                        }
                    }
                }
        }
    }
}

#Preview {
    CongratsView()
        .environment(Game())
}

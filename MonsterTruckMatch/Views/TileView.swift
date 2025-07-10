//
//  TileView.swift
//  MatchingGame
//
//
//

import SwiftUI

struct TileView: View {
    @Environment(Game.self) private var game
    var tile: Tile

    private let borderWidth = 10.0
    var size: CGFloat

    var body: some View {
        ZStack {
            if tile.isFlipped == .same {
                ZStack {
                    Image(tile.truck)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                    Image(systemName: "checkmark")
                        .font(Font.system(size: 90))
                        .foregroundStyle(Color.green)
                        .rotation3DEffect(.degrees(0), axis: (x: 0, y: 1, z: 0))
                }
            } else if tile.isFlipped == .first {
                Image(tile.truck)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
//                VStack {
//                    Text(tile.princess)
//                        .font(.title)
//                        .padding(.top)
//                }
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.red)
            }
        }
        .onTapGesture {
            tileFlip()
        }
        .aspectRatio(1, contentMode: .fit)
        .rotation3DEffect(.degrees(tile.isFlipped == .wrong ? 180 : 0), axis: (x: 1, y: 0, z: 0))
        .animation(.default, value: tile.isFlipped)
    }

    func borderStyle() -> some ShapeStyle {
        return LinearGradient(colors: [
            Color(red: 157.0/255.0, green: 153.0/255.0, blue: 244.0/255.0),
            Color(red: 246.0/255.0, green: 206.0/255.0, blue: 241.0/255.0),
        ], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    func tileFlip() {
        if game.canFlip {
            if tile.isFlipped == .first {
                tile.isFlipped = .wrong
                game.firstFlipped = Tile(truck: "")
            } else if tile.isFlipped == .wrong && game.firstFlipped.truck == "" {
                tile.isFlipped = .first
                game.firstFlipped = tile
            } else if tile.isFlipped == .wrong && tile.truck == game.firstFlipped.truck {
                tile.isFlipped = .same
                game.firstFlipped.isFlipped = .same
                game.firstFlipped = Tile(truck: "")
                game.tileCorrectCount += 2
                if game.tileCorrectCount == game.getTileCount() {
                    game.canFlip = false
                }
            } else if tile.isFlipped == .wrong {
                tile.isFlipped = .first
                Task {
                    game.canFlip = false
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    game.canFlip = true
                    tile.isFlipped = .wrong
                    game.firstFlipped.isFlipped = .wrong
                    game.firstFlipped = Tile(truck: "")
                }
            }
        }
    }
}

#Preview {
    let tile = Tile(truck: "redtruck")
    TileView(tile: tile, size: 200)
        .onTapGesture {
            if tile.isFlipped == .first {
                tile.isFlipped = .wrong
            } else if tile.isFlipped == .wrong {
                tile.isFlipped = .first
            }
        }
        .environment(Game())
}

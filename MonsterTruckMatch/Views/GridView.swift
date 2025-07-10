//
//  GridView.swift
//  MatchingGame
//
//  Created by Ben Taylor on 5/25/25.
//

import SwiftUI

struct GridView: View {
    @Environment(Game.self) private var game
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let tileSpacing: CGFloat = 8
            let horizontalPadding: CGFloat = 16
            let desiredTileWidth: CGFloat = 80
            
            let availableWidth = width - horizontalPadding * 2

            let columnCount = max(Int((width - 2 * horizontalPadding + tileSpacing) / (desiredTileWidth + tileSpacing)), 2)
            let totalSpacing = tileSpacing * CGFloat(columnCount - 1)
            let tileSize = (availableWidth - totalSpacing) / CGFloat(columnCount)

            let gridItems = Array(repeating: GridItem(.fixed(tileSize), spacing: tileSpacing), count: columnCount)
            LazyVGrid(columns: gridItems, spacing: tileSpacing) {
                ForEach(game.tiles, id: \.self) { item in
                    TileView(tile: item, size: tileSize)
                        .frame(width: tileSize, height: tileSize)
                }
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.top, tileSpacing)
        }
    }
}

#Preview {
    GridView()
        .environment(Game())
}

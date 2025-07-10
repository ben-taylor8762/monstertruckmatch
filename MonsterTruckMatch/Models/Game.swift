//
//  Game.swift
//  MatchingGame
//
//  Created by Ben Taylor on 4/26/25.
//

import Foundation

@Observable
class Game {
    var tileCount = 8
    var tileCorrectCount = 0
    var size: CGFloat = 800
    private var trucks: [String]
    var firstFlipped = Tile(truck: "")
    var hasWon = true
    var canFlip = true
    var columnCount = 4
    
    var message: Message = .instructions
    var score = 0
    var tiles = [Tile]()
    
    init() {
        trucks = Trucks.selectRandomTrucks(count: 2)
        startNewGame(truckCount: 4, columnCount: 4)
        size = 800 / CGFloat(tileCount)
    }
    
    func flipTile(flippedPrincess: String) -> Flip {
        if firstFlipped.truck == "" {
            firstFlipped.truck = flippedPrincess
            return .first
        } else if firstFlipped.truck == flippedPrincess {
            firstFlipped.truck = ""
            return .same
        } else {
            firstFlipped.truck = ""
            return .wrong
        }
    }
    
    // MARK: private implementation
    
    // update `tiles` with new unalphabetized set of words
    func startNewGame(truckCount: Int, columnCount: Int) {
        self.tileCount = truckCount * 2
        self.tileCorrectCount = 0
        self.columnCount = columnCount
        trucks = Trucks.selectRandomTrucks(count: truckCount)
        trucks = trucks + trucks
        if !tiles.isEmpty {
            tiles.removeAll()
        }
        for truck in trucks {
            tiles.append(Tile(truck: truck))
        }
        randomizeTiles()
    }
    
    func getTileCount() -> Int {
        return tileCount
    }
    
    func randomizeTiles() {
        var tempTiles = tiles.shuffled()
        while tempTiles.sorted() == tempTiles {
            tempTiles.shuffle()
        }
        tiles = tempTiles
    }
}

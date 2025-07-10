//
//  Princesses.swift
//  MatchingGame
//
//  Created by Ben Taylor on 4/27/25.
//

import Foundation

struct Trucks {
    let chosen: [String]
    
    static func selectRandomTrucks(count: Int) -> [String] {
        var newChosen = Array(names.shuffled().prefix(count))
        while newChosen.sorted() == newChosen {
            newChosen.shuffle()
        }
        return newChosen
    }
    
    static let names: [String] = [
        "blackflamestruck",
        "bluestartruck",
        "bluetruck",
        "browntruck",
        "greentruck",
        "manillatruck",
        "orangetruck",
        "pinktruck",
        "purpletruck",
        "redtruck",
        "tealtruck",
        "yellowishtruck"
    ]
}

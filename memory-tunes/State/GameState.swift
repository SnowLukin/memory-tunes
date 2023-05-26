//
//  GameState.swift
//  memory-tunes
//
//  Created by Snow Lukin on 26.05.2023.
//

import ReSwift

struct MemoryCard {
    let imageUrl: String
    var isFlipped: Bool
    var isAlreadyGuessed: Bool
}

struct GameState {
    var memoryCards: [MemoryCard]
    var showLoading: Bool
    var gameFinished: Bool
}


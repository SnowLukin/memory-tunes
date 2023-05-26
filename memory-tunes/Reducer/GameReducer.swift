//
//  GameReducer.swift
//  memory-tunes
//
//  Created by Snow Lukin on 26.05.2023.
//

import ReSwift

func gameReducer(action: Action, state: GameState?) -> GameState {
    var state = state ?? GameState(memoryCards: [], showLoading: false, gameFinished: false)
    
    switch(action) {
    case _ as FetchTunesAction:
        state = GameState(memoryCards: [], showLoading: true, gameFinished: false)
    case let setCardsAction as SetCardsAction:
        state.memoryCards = generateNewCards(with: setCardsAction.cardImageUrls)
        state.showLoading = false
    case let flipCardAction as FlipCardAction:
        state.memoryCards = flipCard(index: flipCardAction.cardIndexToFlip, memoryCards: state.memoryCards)
        state.gameFinished = hasFinishedGame(cards: state.memoryCards)
    default: break
    }
    
    return state
}

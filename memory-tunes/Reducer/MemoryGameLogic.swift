//
//  MemoryGameLogic.swift
//  memory-tunes
//
//  Created by Snow Lukin on 26.05.2023.
//

import Foundation
import GameplayKit

private struct MemoryGameConstants {
    static let numberOfUniqueCards = 8
}
private typealias C = MemoryGameConstants

func generateNewCards(with cardImageUrls:[String]) -> [MemoryCard] {
    var memoryCards = cardImageUrls[0..<C.numberOfUniqueCards].map { image -> MemoryCard in
        MemoryCard(imageUrl: image, isFlipped: false, isAlreadyGuessed: false)
    }
    
    memoryCards.append(contentsOf: memoryCards)
    return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: memoryCards) as! [MemoryCard]
}

func flipCard(index: Int, memoryCards: [MemoryCard]) -> [MemoryCard] {
    var changedCards = memoryCards
    
    changedCards[index].isFlipped = true
    
    let alreadyFlippedCardsInGame = changedCards.filter({ card -> Bool in
        return !card.isAlreadyGuessed && card.isFlipped
    })
    
    if alreadyFlippedCardsInGame.count == 2 {
        let firstCardUrl = alreadyFlippedCardsInGame[0].imageUrl
        let secondCardUrl = alreadyFlippedCardsInGame[1].imageUrl
        
        let playerGuessedRight = firstCardUrl == secondCardUrl
        
        if playerGuessedRight {
            changedCards = checkGuessedCards(for: firstCardUrl, in: changedCards)
        }
    }
    
    if alreadyFlippedCardsInGame.count == 3 {
        changedCards = flipBackCards(changedCards, exceptIndex: index)
    }
    
    return changedCards
}

func checkGuessedCards(for imageUrl: String, in cards: [MemoryCard]) -> [MemoryCard] {
    var changedCards = cards
    for index in 0 ..< cards.count {
        if cards[index].imageUrl == imageUrl {
            changedCards[index].isAlreadyGuessed = true
        }
    }
    
    return changedCards
}

func flipBackCards(_ cards: [MemoryCard], exceptIndex: Int) -> [MemoryCard] {
    var changedCards = cards
    for index in 0 ..< cards.count {
        if index != exceptIndex {
            changedCards[index].isFlipped = false
        }
    }
    
    return changedCards
}

func hasFinishedGame(cards: [MemoryCard]) -> Bool {
    
    for card in cards {
        if !card.isAlreadyGuessed {
            return false
        }
    }
    
    return true
}


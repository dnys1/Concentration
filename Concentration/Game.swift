//
//  Game.swift
//  Concentration
//
//  Created by Dillon Nys on 5/24/20.
//  Copyright © 2020 Dillon Nys. All rights reserved.
//

import Foundation

class Game {
    /// The amount of time per decision.
    static let timePerDecision: Float = 5.0

    var cards = [Card]()
    var isComplete = false
    var score = 0.0
    var timeLeft: Float
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        timeLeft = Game.timePerDecision
        shuffle()
    }
    
    func updateTime() {
        timeLeft = max(timeLeft - 0.1, 0)
    }
    
    func handleTouch(onCard index: Int) {
        if cards[index].isFaceUp {
            if !cards[index].isMatched {
                cards[index].isFaceUp = false
            }
        } else {
            if let upIndex = indexOfOneAndOnlyFaceUpCard {
                if index != upIndex, cards[index].id == cards[upIndex].id {
                    cards[index].isMatched = true
                    cards[upIndex].isMatched = true
                    indexOfOneAndOnlyFaceUpCard = nil
                    
                    let scoreMultiplier = 1.0 - (Game.timePerDecision - timeLeft) / Game.timePerDecision
                    
                    score += Double(2 * scoreMultiplier)
                    
                    if cards.filter({ !$0.isMatched }).isEmpty {
                        isComplete = true
                    }
                } else {
                    for card in cards.filter({ $0.isFaceUp && !$0.isMatched }) {
                        let cardIndex = cards.firstIndex(of: card)!
                        cards[cardIndex].isFaceUp = false
                    }
                    
                    // Penalize 1 pt for getting the match wrong
                    // and having already seen this card.
                    if cards[index].isSeen {
                        let scoreMultiplier = (Game.timePerDecision - timeLeft) / Game.timePerDecision
                        score = max(score - Double(1.0 * scoreMultiplier), 0)
                    }
                    
                    indexOfOneAndOnlyFaceUpCard = index
                }
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].isSeen = true
            cards[index].isFaceUp = true
            
            // Reset the timer.
            timeLeft = Game.timePerDecision
        }
    }
    
    func shuffle() {
        cards.shuffle()
    }
    
    func reset() {
        for cardIndex in cards.indices {
            cards[cardIndex].isMatched = false
            cards[cardIndex].isFaceUp = false
        }
        shuffle()
    }
}

//
//  Game.swift
//  Concentration
//
//  Created by Dillon Nys on 5/24/20.
//  Copyright © 2020 Dillon Nys. All rights reserved.
//

import Foundation

struct Game {
    /// The amount of time per decision.
    private static let timePerDecision: Float = 5.0

    private(set) var cards = [Card]()
    private(set) var isComplete = false
    private(set) var score = 0.0
    private(set) var timeLeft: Float
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if !cards[index].isMatched, cards[index].isFaceUp, foundIndex == nil {
                    foundIndex = index
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                if cards[index].isMatched {
                    cards[index].isFaceUp = true
                } else {
                    cards[index].isFaceUp = (index == newValue)
                }
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): numberOfPairsOfCards must be greater than 0")
        
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        timeLeft = Game.timePerDecision
        shuffle()
    }
    
    mutating func updateTime() {
        timeLeft = max(timeLeft - 0.1, 0)
    }
    
    mutating func handleTouch(onCard index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(onCard: \(index)): chosen index not in the cards")
        
        if cards[index].isFaceUp {
            if !cards[index].isMatched {
                cards[index].isFaceUp = false
            }
        } else {
            if let upIndex = indexOfOneAndOnlyFaceUpCard {
                if index != upIndex, cards[index] == cards[upIndex] {
                    cards[index].isMatched = true
                    cards[upIndex].isMatched = true
                    indexOfOneAndOnlyFaceUpCard = nil
                    
                    let scoreMultiplier = 1.0 - (Game.timePerDecision - timeLeft) / Game.timePerDecision
                    
                    score += Double(2 * scoreMultiplier)
                    
                    if cards.filter({ !$0.isMatched }).isEmpty {
                        isComplete = true
                    }
                } else {
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
            
            // Reset the timer.
            timeLeft = Game.timePerDecision
        }
    }
    
    private mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func reset() {
        for cardIndex in cards.indices {
            cards[cardIndex].isMatched = false
            cards[cardIndex].isFaceUp = false
        }
        shuffle()
    }
}

extension Collection {
    /// For  `Collection`s with only one element, this returns that element.
    /// Returns `nil` for all other Collections.
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

//
//  Card.swift
//  Concentration
//
//  Created by Dillon Nys on 5/24/20.
//  Copyright © 2020 Dillon Nys. All rights reserved.
//

import Foundation

struct Card : Equatable {
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    var id: Int
    
    static var incrementingId = 0
    
    /// Get the next random ID
    static func getRandomId() -> Int {
        incrementingId += 1
        return incrementingId
    }
    
    init() {
        self.id = Card.getRandomId()
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.id == rhs.id
    }
}

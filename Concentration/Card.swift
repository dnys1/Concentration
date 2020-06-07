//
//  Card.swift
//  Concentration
//
//  Created by Dillon Nys on 5/24/20.
//  Copyright © 2020 Dillon Nys. All rights reserved.
//

import Foundation

struct Card : Hashable {
    var isFaceUp = false
    var isMatched = false
    var isSeen = false
    private var id: Int
    
    private static var incrementingId = 0
    
    /// Get the next random ID
    private static func getRandomId() -> Int {
        incrementingId += 1
        return incrementingId
    }
    
    init() {
        self.id = Card.getRandomId()
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    var hashValue: Int {
        return id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//
//  Util.swift
//  Concentration
//
//  Created by Dillon Nys on 5/25/20.
//  Copyright © 2020 Dillon Nys. All rights reserved.
//

import Foundation

class Util {
    static func getRandomIndex(forCount count: Int) -> Int {
        return Int(arc4random_uniform(UInt32(count)))
    }
}

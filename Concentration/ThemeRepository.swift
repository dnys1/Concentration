//
//  ThemeRepository.swift
//  Concentration
//
//  Created by Dillon Nys on 5/25/20.
//  Copyright © 2020 Dillon Nys. All rights reserved.
//

import Foundation
import UIKit

class ThemeRepository {
    private var themes: [Theme]
    private var selectedTheme: Theme
    
    init() {
        themes = [
            Theme(emojiChoices: ["🎃", "💀", "👻", "🦇", "🙀", "😈", "😱", "👹", "🎭", "👽", "🧛‍♂️", "🔥", "🎲", "🎈", "💰"], name: "Halloween", backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), buttonTextColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cardColors: [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)]),
            Theme(emojiChoices: ["🤶", "🎄", "🎅", "🌲", "🎁", "💰", "🧧", "🐃", "🎠", "✨", "🔥", "🍪", "🥛", "❄️", "☃️"], name: "Christmas", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), buttonTextColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardColors: [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.3523305058, blue: 0, alpha: 1)])
        ]
        
        selectedTheme = themes[Util.getRandomIndex(forCount: themes.count)]
    }
    
    func register(theme: Theme) {
        themes.append(theme)
    }
    
    func getNextEmoji() -> String {
        let randomIndex = Util.getRandomIndex(forCount: selectedTheme.emojiChoices.count)
        return selectedTheme.emojiChoices.remove(at: randomIndex)
    }
    
    func getCardColor(for index: Int) -> UIColor {
        let colorIndex = index % selectedTheme.cardColors.count
        return selectedTheme.cardColors[colorIndex]
    }
    
    func getBackgroundColor() -> UIColor {
        return selectedTheme.backgroundColor
    }
    
    func getTextColor() -> UIColor {
        return selectedTheme.textColor
    }
    
    func getButtonTextColor() -> UIColor {
        return selectedTheme.buttonTextColor
    }
}

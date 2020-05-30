//
//  ViewController.swift
//  Concentration
//
//  Created by Dillon Nys on 5/24/20.
//  Copyright © 2020 Dillon Nys. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Game(numberOfPairsOfCards: buttons.count / 2)
    
    var theme = ThemeRepository()
    var timer = Timer()
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    @IBOutlet var background: UIView!
    
    @IBOutlet var controlButtons: [UIButton]!
    
    @IBOutlet weak var countdownProgressView: UIProgressView!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let index = buttons.firstIndex(of: sender) {
            game.handleTouch(onCard: index)
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @objc func tick(_ timer: Timer) {
        game.updateTime()
        updateViewFromModel()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Color background and cards
        for index in buttons.indices {
            buttons[index].backgroundColor = theme.getCardColor(for: index)
        }
        
        for index in controlButtons.indices {
            controlButtons[index].backgroundColor = theme.getCardColor(for: index)
            controlButtons[index].setTitleColor( theme.getButtonTextColor(), for: .normal)
        }
        
        background.backgroundColor = theme.getBackgroundColor()
        
        gameScoreLabel.textColor = theme.getTextColor()
        
        countdownProgressView.progressTintColor = theme.getTextColor()
        countdownProgressView.tintColor = theme.getBackgroundColor()
        
        startTimer()
    }
    
    private var emojis: [Int: String] = [:]
    
    func emoji(for card: Card) -> String {
        if emojis[card.id] == nil {
            emojis[card.id] = theme.getNextEmoji()
        }
        
        return emojis[card.id]!
    }
    
    func updateViewFromModel() {
        for index in buttons.indices {
            let button = buttons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = theme.getCardColor(for: index)
            }
        }
        
        let scoreText = String(format: "%.1f", game.score)
        gameScoreLabel.text = "Game Score: \(scoreText)"
        
        countdownProgressView.progress = game.timeLeft / 5.0
        
        if game.isComplete {
            newGameButton.isEnabled = true
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.reset()
        updateViewFromModel()
    }
    
    
    @IBAction func resetGame(_ sender: UIButton) {
        game.reset()
        updateViewFromModel()
    }
}


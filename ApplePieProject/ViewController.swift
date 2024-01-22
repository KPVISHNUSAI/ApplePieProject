//
//  ViewController.swift
//  ApplePieProject
//
//  Created by user2 on 22/01/24.
//

import UIKit

var listOfWords = ["buccaneer","swift","gloroius","incadescent","bug","program"]
let incorrectMovesAllowed = 7
var totalWins = 0
var totalLosses = 0


class ViewController: UIViewController {

    @IBOutlet var TreeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet var scoreLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    var currentGame: Game!
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed,guessedLetters: [])
            enableLetterButtons(true)
            updateUI();
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI(){
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        TreeImageView.image = UIImage(named:"Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        updateUI()
    }
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }

}

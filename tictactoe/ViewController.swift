//
//  ViewController.swift
//  tictactoe
//
//  Created by Joseph Sungpil Choi on 13/07/2018.
//  Copyright © 2018 Joseph Sungpil Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    enum Move {
        case Blank
        case Player
        case Enemy
    }
    private(set) var combinations = [
        (first: 0, second: 1, third: 2),
        (first: 0, second: 3, third: 6),
        (first: 0, second: 4, third: 8),
        (first: 1, second: 4, third: 7),
        (first: 2, second: 4, third: 6),
        (first: 2, second: 5, third: 8),
        (first: 3, second: 4, third: 5),
        (first: 6, second: 7, third: 8)
    ]
    private(set) var selected: [Move] = [Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank]
    private(set) var locked = false
    var hasWon: Bool {
        get {
            for combination in combinations {
                if checkForWin(firstIndex: combination.first, secondIndex: combination.second, thirdIndex: combination.third) {
                    return true
                }
            }
            return false
        }
    }
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var winLabel: UILabel!
    @IBAction private func handleRestart(_ sender: UIButton) {
        winLabel.text = ""
        selected = [Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank, Move.Blank]
        for button in buttonCollection {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    @IBAction private func handleClick(_ sender: UIButton) {
        if !locked, let buttonNumber = buttonCollection.index(of: sender) {
            if (selected[buttonNumber] != Move.Blank) { return }
            buttonCollection[buttonNumber].setTitle("X", for: UIControlState.normal)
            buttonCollection[buttonNumber].backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            print("buttonNumber: \(buttonNumber)")
            selected[buttonNumber] = Move.Player
            print("is Move.Player: \(selected[buttonNumber])")
            print(selected)
            if hasWon {
                winLabel.text = "You win!"
                return
            }
            
            var unselected: [Int] = []
            for index in selected.indices {
                if selected[index] == Move.Blank { unselected.append(index) }
            }
            if unselected.count == 0 {
                winLabel.text = "You lose :("
                return
            }
            locked = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let randomIndex = unselected[unselected.count.random]
                self.buttonCollection[randomIndex].setTitle("O", for: UIControlState.normal)
                self.buttonCollection[randomIndex].backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                self.selected[randomIndex] = Move.Enemy
                self.locked = false
            }
        }
    }
    
    private func checkForWin(firstIndex first: Int, secondIndex second: Int, thirdIndex third: Int) -> Bool {
        assert(selected.indices.contains(first) && selected.indices.contains(second) && selected.indices.contains(third), "ViewController.checkForWin(firstIndex: \(first), secondIndex: \(second), thirdIndex: \(third)), one or more of these indices is out of bounds")
        return selected[first] == Move.Player && selected[second] == Move.Player && selected[third] == Move.Player
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension Int {
    var random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}


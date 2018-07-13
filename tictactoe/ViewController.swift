//
//  ViewController.swift
//  tictactoe
//
//  Created by Joseph Sungpil Choi on 13/07/2018.
//  Copyright © 2018 Joseph Sungpil Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var selected: [Bool] = [false, false, false, false, false, false, false, false, false]
    var locked = false
    @IBOutlet var buttonCollection: [UIButton]!
    @IBAction func handleClick(_ sender: UIButton) {
        if !locked, let buttonNumber = buttonCollection.index(of: sender) {
            buttonCollection[buttonNumber].setTitle("X", for: UIControlState.normal)
            buttonCollection[buttonNumber].backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            selected[buttonNumber] = true
            var unselected: [Int] = []
            for index in selected.indices {
                if !selected[index] { unselected.append(index) }
            }
            if unselected.count == 0 { return }
            locked = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let randomIndex = unselected[Int(arc4random_uniform(UInt32(unselected.count)))]
                self.buttonCollection[randomIndex].setTitle("O", for: UIControlState.normal)
                self.buttonCollection[randomIndex].backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                self.selected[randomIndex] = true
                self.locked = false
            }
        }
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


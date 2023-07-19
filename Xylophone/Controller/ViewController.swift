//
//  ViewController.swift
//  Xylophone
//
//  Created by Tweety iMac on 14/07/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    override func viewDidLoad() {
            super.viewDidLoad()
        startNewGame()
        
    }
     

        @IBAction func keyPressed(_ sender: UIButton) {
            
            playSound(soundName: sender.currentTitle!)
            sender.alpha = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                sender.alpha = 1.0
        }
        }
        

    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
         
    
    
    
        
        // MARK: -Outlets
        
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var red: UIButton!
   
    @IBOutlet weak var orange: UIButton!
    
    @IBOutlet weak var yellow: UIButton!
    
    @IBOutlet weak var green: UIButton!
    
    @IBOutlet weak var indigo: UIButton!
    
    
    @IBOutlet weak var purple: UIButton!
    
   

    
  
    @IBAction func redTapped() {
        makeMove(red)
    }

    @IBAction func yellowTapped() {
        makeMove(yellow)
    }

    @IBAction func greenTapped() {
        makeMove(green)
    }

    @IBAction func blueTapped() {
        makeMove(blue)
    }
    @IBAction func purpleTapped() {
        makeMove(purple)
    }
    @IBAction func orangeTapped(){
        makeMove(orange)
    }
    @IBAction func indigoTapped(){
        makeMove(indigo)
    }
    
    func makeMove(_ color: UIButton) {
        // don't let the player touch stuff while in watch mode
        guard isWatching == false else { return }
        
        if sequence[sequenceIndex] == color {
            // they were correct! Increment the sequence index.
            sequenceIndex += 1
            
            if sequenceIndex == sequence.count {
                // they made it to the end; add another button to the sequence
                addToSequence()
            }
        } else {
            // they were wrong! End the game.
            
            _ = UIAlertAction(title: "Play Again", style: .default) {_ in
                    self.startNewGame()
                }

           
            }
        }
        
        
        // MARK: - Properties
  
    
        
        var isWatching = true {
            didSet {
                if isWatching {
                    print("WATCH!")
                } else {
                    print("REPEAT!")
                }
            }
        }
        
        
        var sequence = [UIButton]()
        var sequenceIndex = 0
        
        
        
    func playNextSequenceItem() {
        // stop flashing if we've finished our sequence
        guard sequenceIndex < sequence.count else {
            isWatching = false
            sequenceIndex = 0
            return
        }

        // otherwise move our sequence forward
        let button = sequence[sequenceIndex]
        sequenceIndex += 1

        // wait a fraction of a second before flashing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            // mark this button as being active
            button.alpha = 0.5

            // wait again
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // deactivate the button and flash again
                button.alpha = 0.5
                self?.playNextSequenceItem()
            }
        }
    }

            
            
    func addToSequence() {
        let colors: [UIButton] = [red, yellow, green, blue, indigo, orange, purple]

        for _ in 1...10 {
            sequence.append(colors.randomElement()!)
        }

        sequenceIndex = 0
        isWatching = true

        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.playNextSequenceItem()
        }
    }
        
        func startNewGame() {
            sequence.removeAll()
            addToSequence()
        }
    
  
    
    
}












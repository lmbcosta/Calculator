//
//  ViewController.swift
//  calculator
//
//  Created by Luis  Costa on 19/01/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

// Fonts from www.dafont.com/minecraft.font

// Usar para cada botão 1 a 9 uma tag

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var labelScreen: UILabel!
    
    // play/stop audio song
    var buttonAudio: AVAudioPlayer!
    // Current number to operations
    var currentNum = ""
    // Current operation to process
    var currentOP = Operator.None
    var leftNum = ""
    var rightNum = ""
    var result = ""
    var twoOP = false
    // Creating a enum for the operators
    enum Operator {
        case Add
        case Subtract
        case Divide
        case Multiply
        case None
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Create a path for the audio file
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        // Create a URL do the audio file
        let audioURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonAudio = AVAudioPlayer(contentsOf: audioURL)
            // Prepare the sound to play
            buttonAudio.prepareToPlay()
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
    // This funcrion is using only UIButtons
    // that represents nums
    @IBAction func buttonsPressed(sender: UIButton) {
        
        // Just in case...
        if buttonAudio.isPlaying {
            buttonAudio.stop()
        }
        buttonAudio.play()
        
        // Update current num
        currentNum += "\(sender.tag)"
        labelScreen.text = currentNum
        
        twoOP = twoOP ? false : twoOP
    }
    
    
    // Updating the current Operator
    // Using tag 50, 51 for operator buttons
    @IBAction func operatorsReceived(sender: AnyObject) {
        // Audio for buttons operators
        buttonAudio.play()
        // aux variable
        var _auxOP: Operator!
        
        
        switch sender.tag {
        case 50:
            _auxOP = Operator.Divide
        case 51:
            _auxOP = Operator.Multiply
        case 52:
            _auxOP = Operator.Subtract
        case 53:
            _auxOP = Operator.Add
            
        default:
            _auxOP = Operator.None
        }
        
        if !twoOP {
            if currentOP == Operator.None {
                leftNum = currentNum
                currentNum = ""
                currentOP = _auxOP
            }
                // Example: 2 + 2 + -> show 4 and wait for another number
            else if leftNum != "" {
                
                rightNum = currentNum
                calculateFunc()
                leftNum = result
                currentOP = _auxOP
                currentNum = ""
            }
            twoOP = true
        }
    }
    
    // Proceed the cald with the elements
    func calculateFunc() {

        // Execute the oparation depending the operator
        switch currentOP {
        case Operator.Add:
            result = "\(Double(leftNum)! + Double(rightNum)!)"
        
        case Operator.Multiply:
            result = "\(Double(leftNum)! * Double(rightNum)!)"
        
        case Operator.Subtract:
            result = "\(Double(leftNum)! - Double(rightNum)!)"
        
        case Operator.Divide:
            result = "\(Double(leftNum)! / Double(rightNum)!)"
            
        default: break
        }
        labelScreen.text = result
        // reset left and right nums
        leftNum = ""
        rightNum = ""
        currentNum = result
        currentOP = Operator.None
    }
    
    @IBAction func equals(sender: UIButton) {
        buttonAudio.play()
        
        if leftNum != "" && currentOP != Operator.None {
            rightNum = currentNum
            calculateFunc()
        }
    }
}


//
//  ViewController.swift
//  calculator
//
//  Created by Luis  Costa on 19/01/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

// Fonts from www.dafont.com/minecraft.font

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
//    ButtonSound
//    An instance of the AVAudioPlayer class,
//    called an audio player, provides playback of
//    audio data from a file or memory.
    var buttonSound: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Path for the song file
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        // Create an URL
        let buttonURL = URL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOf: buttonURL)
            buttonSound.prepareToPlay()
            
        } catch let error as NSError{
            print(error.debugDescription)
        }
    }
    
    // Function that when the keys are pressed 
    // plays the fuzzy song
    @IBAction func buttonsPressed(sender: UIButton) {
        // Just in case test stops the sound
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        buttonSound.play()
    }
}


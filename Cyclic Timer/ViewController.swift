//
//  ViewController.swift
//  Cyclic Timer
//
//  Created by Avaneep Gupta on 6/27/20.
//  Copyright © 2020 Avaneep Gupta. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var totalTimeHandler: UILabel!
    var intervalTime = 5
    var timer = Timer()
    var secondsPassed = 0
    let speechSynthesizer = AVSpeechSynthesizer()
    var speechUtterance = AVSpeechUtterance(string: "Hello")
    @IBOutlet weak var durationHandler: UITextField!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        durationHandler.delegate = self
    
    }



    
    @IBAction func keyPressed(_ sender: UIButton) {
        
        let buttonPressed = sender.currentTitle!
        print(buttonPressed)
        
        if buttonPressed == "Start" {
            
            if(durationHandler.text=="") {
                return
            }
            durationHandler.resignFirstResponder()
            timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            intervalTime = Int(durationHandler.text!)!
            
        }
        else {
            durationHandler.resignFirstResponder()
            timer.invalidate()
            secondsPassed = 0
        }
            
            
    }
    
    @objc func updateCounter() {
        
        secondsPassed += 1
        totalTimeHandler.text = String(secondsPassed) + " Seconds"
        if secondsPassed % intervalTime==0 {
            speechUtterance = AVSpeechUtterance(string: String(intervalTime)+" Seconds")
            speechSynthesizer.speak(speechUtterance)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        durationHandler.resignFirstResponder()
    }
    
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

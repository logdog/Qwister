//
//  TwisterViewTwo.swift
//  Twister
//
//  Created by Logan Dihel on 6/15/16.
//  Copyright © 2016 Logan Dihel. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class TwisterViewTwo: UIViewController {

    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    
    @IBOutlet weak var leftFootImage: UIImageView!
    @IBOutlet weak var leftHandImage: UIImageView!
    @IBOutlet weak var rightHandImage: UIImageView!
    @IBOutlet weak var rightFootImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timeLeft: Double = -1
    var automatic = false
    var timeBetweenTurns: Double = -1
    var timer = NSTimer()
    
    var seconds: Int = 0
    var minutes: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeLabel.text = "Tap to Spin"
        changeLabel.textColor = UIColor.blackColor()
        
        leftFootImage.transform = CGAffineTransformMakeScale(-1, 1)
        leftHandImage.transform = CGAffineTransformMakeScale(-1, 1)
        
        timeLeft = timeBetweenTurns
        
        if timeBetweenTurns >= -1 {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TwisterViewTwo.update), userInfo: nil, repeats: true)
        }
        
        if automatic {
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TwisterViewTwo.buttonPressed), userInfo: nil, repeats: false)
            changeLabel.text = " "
        }
    }
    
    func update() {
        seconds += 1
        timeLeft -= 1
        if timeLeft == 0 {
            buttonPressed()
        }
        
        if seconds >= 60 {
            seconds -= 60
            minutes += 1
        }
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func buttonPressed() {
        timeLeft = timeBetweenTurns
        
        UIView.animateWithDuration(1.0, animations: {
            self.spinButton.transform = CGAffineTransformMakeRotation(CGFloat((Double(arc4random())) / (M_PI)))
        })
        
        let labelArray = [leftFootImage, leftHandImage, rightHandImage, rightFootImage]
        let rand = Int(arc4random() % 4)
        
        changeColor(labelArray[rand]!, number: rand)
    }
    
    @IBAction func spinButtonPressed(sender: UIButton) {
        if !automatic {
            buttonPressed()
        }
    }
    
    func changeColor(imageView: UIImageView, number: Int) {
        var rand = Int(arc4random() % 4)
        var message = ""
        //hand
        if number == 1 || number == 2 {
        
            let handArray = [UIImage(named: "HandGreen"), UIImage(named: "HandYellow"), UIImage(named: "HandBlue"), UIImage(named: "HandRed")]
            if imageView.image!.isEqual(handArray[rand]){
                rand += 1
                rand %= 4
            }
            
            imageView.image = handArray[rand]
            
            if number == 1 {
                message += "Left"
            }
            else {
                message += "Right"
            }
            
            message += " Hand"
            changeLabel.text = message
            
        }
        
        //foot
        else {
            let footArray = [UIImage(named: "FootGreen"), UIImage(named: "FootYellow"), UIImage(named: "FootBlue"), UIImage(named: "FootRed")]
            if imageView.image!.isEqual(footArray[rand]){
                rand += 1
                rand %= 4
            }
            
            imageView.image = footArray[rand]
            
            if number == 0 {
                message += "Left"
            }
            else {
                message += "Right"
            }
            
            message += " Foot"
            changeLabel.text = message
        }
        
        switch rand {
        case 0:
            changeLabel.textColor = UIColor.greenColor()
            message += " Green"
        case 1:
            changeLabel.textColor = UIColor.yellowColor()
            message += " Yellow"
        case 2:
            changeLabel.textColor = UIColor.blueColor()
            message += " Blue"
        case 3:
            changeLabel.textColor = UIColor.redColor()
            message += " Red"
        default:
            changeLabel.textColor = UIColor.blackColor()
        }
        
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer.invalidate()
        if minutes > 0 || seconds > 20 {
            let gp = NSUserDefaults.standardUserDefaults().integerForKey("GamesPlayed") + 1
            NSUserDefaults.standardUserDefaults().setInteger(gp, forKey: "GamesPlayed")
        }
    }
}

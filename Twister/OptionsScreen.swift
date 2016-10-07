//
//  OptionsScreen.swift
//  Twister
//
//  Created by Logan Dihel on 6/11/16.
//  Copyright © 2016 Logan Dihel. All rights reserved.
//

import Foundation
import UIKit

class OptionsScreen : UIViewController {
    
    @IBOutlet weak var sbrLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var back = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var seconds = NSUserDefaults.standardUserDefaults().doubleForKey("Seconds")
        var index = NSUserDefaults.standardUserDefaults().integerForKey("Index")
        
        if seconds == 0 {
            seconds = 7
            index = 1
        }
        
        stepper.autorepeat = false
        stepper.minimumValue = 2
        stepper.maximumValue = 20
        stepper.stepValue = 1
        stepper.value = seconds
        
        sbrLabel.text = "Seconds Between Rounds: " + "\(Int(stepper.value))"
    
        segment.selectedSegmentIndex = index
        
        if(index == 0) {
            stepper.userInteractionEnabled = false
            sbrLabel.alpha = 0.5
        }
        
    }
    @IBAction func backTapped(sender: UIButton) {
        back = true
    }
    
    @IBAction func segmentTapped(sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            sbrLabel.alpha = 0.5
            stepper.userInteractionEnabled = false
        }
        else {
            sbrLabel.alpha = 1.0
            stepper.userInteractionEnabled = true
        }
    }
    
    @IBAction func start(sender: UIButton) {
        back = false
    }
    @IBAction func stepperTapped(sender: AnyObject) {
        sbrLabel.text = "Seconds Between Rounds: " + "\(Int(stepper.value))"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        NSUserDefaults.standardUserDefaults().setDouble(stepper.value, forKey: "Seconds")
        NSUserDefaults.standardUserDefaults().setInteger(segment.selectedSegmentIndex, forKey: "Index")
        
        if !back {
        let vc = segue.destinationViewController as! TwisterViewTwo
        if segment.selectedSegmentIndex > 0 {
            vc.timeBetweenTurns = stepper.value
        }
        if segment.selectedSegmentIndex == 2 {
            vc.automatic = true
        }
        }
    }
}
//
//  ViewController.swift
//  Twister
//
//  Created by Logan Dihel on 6/11/16.
//  Copyright © 2016 Logan Dihel. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var redCircle: Circle!
    @IBOutlet weak var greenCircle: Circle!
    @IBOutlet weak var yellowCircle: Circle!
    @IBOutlet weak var blueCircle: Circle!
    @IBOutlet weak var gamesPlayed: UILabel!
    
    var lastRandom: UInt32 = 4

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        blueCircle.setCircleColor(UIColor.blueColor())
        redCircle.setCircleColor(UIColor.redColor())
        greenCircle.setCircleColor(UIColor.greenColor())
        yellowCircle.setCircleColor(UIColor.yellowColor())
        
        blueCircle.alpha = 0.0
        redCircle.alpha = 0.0
        greenCircle.alpha = 0.0
        yellowCircle.alpha = 0.0
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        
        let gp = NSUserDefaults.standardUserDefaults().integerForKey("GamesPlayed")
        gamesPlayed.text = "Games Played: \(gp)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of anyresources that can be recreated.
    }
    
    func update() {
        var rand: UInt32 = 4
        repeat {
            rand = arc4random() % 4
        } while rand == lastRandom
        
        lastRandom = rand
        var circle: Circle = redCircle
        
        switch rand {
        case 0:
            circle = redCircle
        case 1:
            circle = greenCircle
        case 2:
            circle = yellowCircle
        case 3:
            circle = blueCircle
        default:
            circle = blueCircle
        }
        
        UIView.animateWithDuration(1.0, animations: {
            circle.alpha = 1.0
            }, completion: { (finished: Bool) in
                UIView.animateWithDuration(1.0, animations: {
                    circle.alpha = 0.0
                })
        })
    }
}

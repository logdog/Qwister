//
//  Circle.swift
//  Twister
//
//  Created by Logan Dihel on 6/18/16.
//  Copyright © 2016 Logan Dihel. All rights reserved.
//

import CoreGraphics
import UIKit

class Circle: UIView {
    
    var color = UIColor.blackColor()

    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        color.setFill()
        path.fill()
    }
    
    func setCircleColor(color: UIColor) {
        self.color = color
    }
    
}

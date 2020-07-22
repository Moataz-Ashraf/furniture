//
//  CustomTabBar.swift
//  furniture
//
//  Created by Moataz on 7/20/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class  CustomTabBar :UITabBar{
    
    var shapLayer : CALayer?
    override func draw(_ rect: CGRect) {
        self.addShap()
    }
    func addShap(){
        let ShapLayer = CAShapeLayer()
        ShapLayer.path = CreatePath()
        ShapLayer.fillColor = UIColor.white.cgColor
        ShapLayer.strokeColor = UIColor.lightGray.cgColor
        ShapLayer.lineWidth = 0.5
        ShapLayer.shadowColor = UIColor.orange.cgColor
        ShapLayer.shadowRadius = 5
        
        if let oldLayer = self.shapLayer {
            self.layer.replaceSublayer(oldLayer, with: ShapLayer)
        }else{
            self.layer.insertSublayer(ShapLayer, at: 0)
        }
        
        self.shapLayer = ShapLayer
    }
    func CreatePath () -> CGPath {
       let  path  = UIBezierPath()
        
                let height: CGFloat = 37.0
                let width  = UIScreen.main.bounds.width
                 let frameHeight  = UIScreen.main.bounds.height
                let centerWidth = UIScreen.main.bounds.width/2
        
                    path.move(to: CGPoint(x: 0, y: 0)) // start top left
                    path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        
                    path.addCurve(to: CGPoint(x: centerWidth, y: height),
                                  controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))
        
                    path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                                  controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        
                    path.addLine(to: CGPoint(x: width, y: 0))
                    path.addLine(to: CGPoint(x: width, y: frameHeight))
                    path.addLine(to: CGPoint(x: 0, y: frameHeight))
                    path.close()
        return path.cgPath
        
            
    }
}

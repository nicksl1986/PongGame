//
//  BackgroundShapes.swift
//  Pong
//
//  Created by Nick Slobodsky on 24/10/2018.
//  Copyright © 2018 Nick Slobodsky. All rights reserved.
//

import Foundation
import SpriteKit

class BShapes : SKNode
{
    var circle = SKShapeNode()
    
    let radius : CGFloat = 150
    
    override init()
    {
        super.init()
        
        circle = SKShapeNode(circleOfRadius: radius)
        
        circle.lineWidth = 1
        
        circle.strokeColor = .white
        
        self.addChild(circle)
        
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: -1000, y: 0))
        
        path.addLine(to: CGPoint(x: 1000, y: 0))
        
        let line = SKShapeNode(path: path)
        
        line.strokeColor = .white
        
        line.lineWidth = 1
        
        self.addChild(line)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

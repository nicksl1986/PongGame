//
//  Paddle.swift
//  Pong
//
//  Created by Nick Slobodsky on 22/10/2018.
//  Copyright © 2018 Nick Slobodsky. All rights reserved.
//

import Foundation
import SpriteKit

class Paddle : SKNode
{
    var rectangle = SKShapeNode()
    
    override init()
    {
        super.init()
        
        rectangle = SKShapeNode(rectOf: CGSize(width: 200, height: 40))
        
        rectangle.fillColor = UIColor(red: 125/255, green: 132/255, blue: 145/255, alpha: 1)
        
        rectangle.lineWidth = 0
        
        self.addChild(rectangle)
        
        physicsBody = SKPhysicsBody(rectangleOf: rectangle.frame.size)
        
        physicsBody?.isDynamic = false
        
        physicsBody?.affectedByGravity = false
        
        physicsBody?.allowsRotation = false
        
        physicsBody?.linearDamping = 0
        
        physicsBody?.angularDamping = 0
        
        physicsBody?.friction = 0
        
        physicsBody?.restitution = 0
        
        physicsBody?.categoryBitMask = BitMask.Paddle
        
        physicsBody?.collisionBitMask = BitMask.Ball
        
        physicsBody?.contactTestBitMask = BitMask.Ball
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


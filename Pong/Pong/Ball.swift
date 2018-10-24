//
//  Ball.swift
//  Pong
//
//  Created by Nick Slobodsky on 22/10/2018.
//  Copyright © 2018 Nick Slobodsky. All rights reserved.
//

import SpriteKit

class Ball : SKNode
{
    var circle = SKShapeNode()
    
    let radius : CGFloat = 15
    
    override init()
    {
        super.init()
        
        circle = SKShapeNode(circleOfRadius: radius)
        
        circle.fillColor = .white 
        
        self.addChild(circle)
        
        physicsBody = SKPhysicsBody(circleOfRadius: radius)
        
        physicsBody?.isDynamic = true
        
        physicsBody?.affectedByGravity = false
        
        physicsBody?.allowsRotation = true
        
        physicsBody?.linearDamping = 0
        
        physicsBody?.angularDamping = 0
        
        physicsBody?.friction = 0.5
        
        physicsBody?.restitution = 1
        
        physicsBody?.categoryBitMask = BitMask.Ball
        
        physicsBody?.collisionBitMask = BitMask.Paddle
        
        physicsBody?.contactTestBitMask = BitMask.Paddle 
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

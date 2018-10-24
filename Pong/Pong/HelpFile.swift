//
//  HelpFile.swift
//  Pong
//
//  Created by Nick Slobodsky on 22/10/2018.
//  Copyright © 2018 Nick Slobodsky. All rights reserved.
//

import UIKit
import SpriteKit

func randomCGFloat(_ lowerLimit : CGFloat, _ upperLimit : CGFloat) -> CGFloat
{
    return lowerLimit + CGFloat(arc4random()) / CGFloat(UInt32.max) * (upperLimit - lowerLimit)
}

func linearSpeed(_ dx : CGFloat, _ dy: CGFloat) -> CGFloat
{
    return sqrt(pow(dx, 2)) + pow(dy, 2)
}

extension GameScene
{
    func contactBetween(_ contact : SKPhysicsContact, _ a : UInt32, _ b : UInt32, complete : () -> ())
    {
        let maskA = contact.bodyA.categoryBitMask
        
        let maskB = contact.bodyB.categoryBitMask
        
        if maskA == a && maskB == b || maskA == b && maskB == a
        {
            complete()
        }
    }
    
    func contactInstance( _ contact : SKPhysicsContact, _ a : UInt32, _ b : UInt32, complete : ( _ node1 : SKNode, _ node2 : SKNode) -> ())
    {
        let maskA = contact.bodyA.categoryBitMask
        
        let maskB = contact.bodyB.categoryBitMask
        
        var bodyA = SKPhysicsBody()
        
        var bodyB = SKPhysicsBody()
        
         if maskA == a && maskB == b || maskA == b && maskB == a
         {
                if maskA == a
                {
                        bodyA = contact.bodyA
                    
                        bodyB = contact.bodyB
                }
            
                if maskA == b
                {
                        bodyA = contact.bodyB
                    
                        bodyB = contact.bodyA
                }
            
                complete(bodyA.node!, bodyB.node!)
         }
    }
}

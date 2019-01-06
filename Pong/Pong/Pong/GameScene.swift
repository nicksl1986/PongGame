//
//  GameScene.swift
//  Pong
//
//  Created by Nick Slobodsky on 21/10/2018.
//  Copyright © 2018 Nick Slobodsky. All rights reserved.
//

import SpriteKit
import GameplayKit

struct BitMask
{
    static let Ball : UInt32 = 0x1 << 0
    
    static let Paddle : UInt32 = 0x1 << 1
    
}

enum GamePhase
{
    case Ready
    
    case Inplay
    
    case GameOver
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabelPlayer = SKLabelNode()
    
    var opponentLabelPlayer = SKLabelNode()
    
    var ball = Ball()
    
    var playerPaddle = Paddle()
    
    var opponentPaddle = Paddle()
    
    var phase = GamePhase.Ready
    
    var skillLevel : CGFloat = 4
    
    var playerScore = 0
    
    var opponentScore = 0
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        scoreLabelPlayer = childNode(withName: "computerScore") as! SKLabelNode
        
        opponentLabelPlayer = childNode(withName: "playerScore") as! SKLabelNode
        
        scoreLabelPlayer.text = "Hey there."
        
        let bShapes = BShapes()
        
        bShapes.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        self.addChild(bShapes)
        
        playerPaddle.name = "Player"
        
        playerPaddle.position = CGPoint(x: self.size.width / 2, y: 200)
        
        playerPaddle.rectangle.fillColor = UIColor(red: 244/255, green: 122/255, blue: 233/255, alpha: 1)
        
        self.addChild(playerPaddle)
        
        opponentPaddle.name = "Opponent"
        
        opponentPaddle.position = CGPoint(x: self.size.width / 2, y: self.size.height - 200)
        
        self.addChild(opponentPaddle)
        
        scoreLabelPlayer.text = "\(playerScore)"
        
        opponentLabelPlayer.text = "\(opponentScore)"
        
        ball.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        self.addChild(ball)
        
        resetGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if phase == .Ready
        {
            phase = .Inplay
            
            startGame()
            
        }
        
        if phase == .GameOver
        {
            phase = .Ready
            
            resetGame()
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches
        {
            let location = t.location(in: self)
            
            playerPaddle.position.x = location.x
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        contactInstance(contact, BitMask.Ball, BitMask.Paddle) { (node1, node2) in
            
            let paddle = node2 as! Paddle
            
            let w = paddle.rectangle.frame.width
            
            let rightOfPaddle = paddle.position.x + w/2
            
            let dist = rightOfPaddle - ball.position.x
            
            let minAngle = CGFloat.pi * 1/6
            
            let maxAngle = CGFloat.pi * 5/6
            
            let v = linearSpeed((ball.physicsBody?.velocity.dx)! , (ball.physicsBody?.velocity.dy)!)
            
            if paddle.name == "Player"
            {
                if ball.position.y > paddle.position.y + 20
                {
                    
                    let angle = minAngle + (maxAngle - minAngle) * (dist/w)
                    
                    ball.physicsBody?.velocity.dx = v * cos(angle)
                    
                    ball.physicsBody?.velocity.dy = v * sin(angle)
                }
            }
            
            if paddle.name == "Opponent"
            {
                if ball.position.y < paddle.position.y - 20
                {
                    let angle = -minAngle + (-maxAngle - (-minAngle)) * (dist/w)
                    
                    ball.physicsBody?.velocity.dx = v * cos(angle)
                    
                    ball.physicsBody?.velocity.dy = v * sin(angle)
                }
                
            }
            
            // slightly increases the ball speed :
            
            ball.physicsBody?.velocity.dx *= 1.1
            
            ball.physicsBody?.velocity.dy *= 1.1
        }
        
    }
    
    override func didSimulatePhysics() {
        
        // scoring :
        
        if phase == .Inplay
        {
            if ball.position.y < 0
            {
                opponentScore += 1
                
                phase = .GameOver
                
                opponentLabelPlayer.text = "\(opponentScore)"
            }
            
            if ball.position.y > self.size.height
            {
                playerScore += 1
                
                phase = .GameOver
                
                scoreLabelPlayer.text = "\(playerScore)"
                
                skillLevel += 1
            }
            
            // bounce of the walls :
            
            if ball.position.x <= 0
            {
                ball.position.x += 1
                
                ball.physicsBody?.velocity.dx *= -1
            }
            
            if ball.position.x >= self.size.width
            {
                ball.position.x = 1
                
                ball.physicsBody?.velocity.dx *= -1
            }
            
            // computer intelligence :
            
            let dx = ball.position.x - opponentPaddle.position.x
            
            if dx >= skillLevel
            {
                opponentPaddle.position.x += skillLevel
            }
            else if dx <= -skillLevel
            {
                opponentPaddle.position.x -= skillLevel
            }
            else
            {
                opponentPaddle.position.x += dx
            }
        }
        
    }
    
    func resetGame()
    {
        
        ball.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        opponentPaddle.position.x = self.size.width / 2
    }
    
    func startGame()
    {
        var a  = CGFloat()
        
        if randomCGFloat(0, 1) < 0.5
        {
            a = randomCGFloat(CGFloat.pi * 1/4, CGFloat.pi * 3/4)
        }
        else
        {
            a = randomCGFloat(-CGFloat.pi * 1/4, -CGFloat.pi * 3/4)
        }
        
        // give the ball velocity :
        
        let v : CGFloat = 400
        
        let dx = v * cos(a)
        
        let dy = v * sin(a)
        
        ball.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
}

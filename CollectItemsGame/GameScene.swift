//
//  GameScene.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/8/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var player: SKSpriteNode!
    var isFingerOnPlayer = false
    
    override func didMove(to view: SKView) {
        initializeUI()
        initializeBackground()
        initializePlayer()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch!.location(in: self)
        
        if let body = physicsWorld.body(at: location) {
            if body.node!.name == player.name {
                print("touched player")
                isFingerOnPlayer = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isFingerOnPlayer {
            let touch = touches.first
            let currLocation = touch!.location(in: self)
            let prevLocation = touch!.previousLocation(in: self)
            let player = childNode(withName: "player") as! SKSpriteNode
            var playerX = player.position.x + (currLocation.x - prevLocation.x)
            
            playerX = max(playerX, player.size.width/2)
            playerX = min(playerX, size.width - player.size.width/2)
            
            player.position = CGPoint(x: playerX, y: player.position.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isFingerOnPlayer = false
    }
    
    func initializeUI() {
        // Steven can do UI
    }
    
    func initializeBackground() {
        // Load up background asset with a level ground for player to stand on
        // let background = SKSpriteNode(imageNamed: "Background")
        // Add background asset to view
        /*
        self.addChild(background)
        */
        let ground = SKSpriteNode(color: SKColor.green, size: CGSize(width: size.width, height: 175))
        ground.anchorPoint = CGPoint(x: 0, y: 0)
        ground.position = CGPoint(x: 0, y: 0)
        ground.zPosition = 1
        self.addChild(ground)
        
        let sky = SKSpriteNode(color: SKColor.cyan, size: CGSize(width: size.width, height: size.height))
        sky.anchorPoint = CGPoint(x: 0, y: 0)
        sky.position = CGPoint(x: 0, y: 0)
        sky.zPosition = 0
        self.addChild(sky)
        // For testing purposes set scene's background color to white
        self.backgroundColor = SKColor.white
    }
    
    func initializePlayer() {
        // Load up player asset as brown rectangle
        player = SKSpriteNode(color: SKColor.brown, size: CGSize(width: 40, height: 100))
        // Set the player's initial position and anchor point
        player.position = CGPoint(x: size.width / 2, y: 225)
        // Set the player's position to be in the foreground rather than background
        player.zPosition = 1
        // Set the player's name for identification
        player.name = "player"
        // Add physics body to the player to interact with other objects
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
        // Turn off gravity for the player so he doesn't fall through the ground
        player.physicsBody?.affectedByGravity = false
        // Don't allow physics to affect player
        player.physicsBody?.isDynamic = false
        // Don't allow the player to experience friction
        player.physicsBody?.friction = 0.0
        // Add the player to the scene
        self.addChild(player)
    }
}

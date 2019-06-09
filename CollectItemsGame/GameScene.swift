//
//  GameScene.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/8/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var player: SKSpriteNode!
    var fruit: SKSpriteNode!
    var rotten: SKSpriteNode!
    var isFingerOnPlayer = false
    var lives = 3
    var numCapFruits = 0
    var currentScore: SKLabelNode!
    var livesLabel: SKLabelNode!
    var duration = 5.0
    
    override func didMove(to view: SKView) {
        setUpPhysics()
        initializeUI()
        initializeBackground()
        initializePlayer()
        startSpawner()
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.node!.name == "player" && contact.bodyB.node!.name == "fruit") ||
            (contact.bodyA.node!.name == "fruit" && contact.bodyB.node!.name == "player"){
            let shrink = SKAction.scale(to: 0, duration: 0.08)
            let removeNode = SKAction.removeFromParent()
            let sequence = SKAction.sequence([shrink,removeNode])
            fruit.run(sequence)
            numCapFruits += 1
            currentScore.text = "Score: " + String(numCapFruits)
        }
    }
    
    func setUpPhysics() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.speed = 1.0
    }
    
    func initializeUI() {
        // Steven can do UI
        currentScore = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        currentScore.fontColor = SKColor.black
        currentScore.text = "Score: " + String(numCapFruits)
        currentScore.position = CGPoint(x: (self.size.width/2) - 100, y: self.size.height - 75)
        self.addChild(currentScore)
        
        livesLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        livesLabel.fontColor = SKColor.red
        livesLabel.text = "Lives: " + String(lives)
        livesLabel.position = CGPoint(x: (size.width/2) + 100, y: size.height - 75)
        self.addChild(livesLabel)
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
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = 2
        
        self.addChild(player)
    }
    
    func startSpawner() {
        spawnFruit()
        spawnRotten()
    }
    
    private func spawnFruit() {
        let wait = SKAction.wait(forDuration: duration, withRange: 2)
        let spawn = SKAction.run {
            self.fruit = Fruit(color: SKColor.yellow, size: CGSize(width: 40, height: 40))
            let xRange = 0...self.size.width
            let xPos = CGFloat.random(in: xRange)
            self.fruit.position = CGPoint(x: xPos, y: self.size.height + 50)
            self.addChild(self.fruit)
        }
        
        let sequence = SKAction.sequence([wait,spawn])
        self.run(SKAction.repeatForever(sequence))
    }
    
    private func spawnRotten() {
        
    }
}

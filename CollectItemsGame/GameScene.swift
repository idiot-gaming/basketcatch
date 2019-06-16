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
    var basket: SKSpriteNode!
    var basketSideL: SKSpriteNode!
    var basketSideR: SKSpriteNode!
    var basketBottom: SKSpriteNode!
    var isFingerOnPlayer = false
    var lives = 3
    var numCapFruits = 0
    var currentScore: SKLabelNode!
    var livesLabel: SKLabelNode!
    var fruitDuration = 5.0
    var rottenDuration = 7.0
    var fruits: [Fruit] = []
    var rottens: [Rotten] = []
    
    override func didMove(to view: SKView) {
        setUpPhysics()
        initializeUI()
        initializeBackground()
        initializePlayer()
        initializeBasket()
        startSpawner()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if lives <= 0 {
            // End the game and return to main menu
            let mainMenuScene = MainMenuScene(fileNamed: "MainMenuScene")!
            let transition = SKTransition.fade(withDuration: 1)
            view!.presentScene(mainMenuScene, transition: transition)
            lives = 3
        }
        
        removeFruit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch!.location(in: self)
        
        if let body = physicsWorld.body(at: location) {
            if body.node!.name == player.name || body.node!.name == basket.name
            || body.node!.name == basketSideL.name || body.node!.name == basketSideR.name
            || body.node!.name == basketBottom.name {
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
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if (nodeA.name == "basket" && nodeB.name == "fruit") ||
            (nodeA.name == "fruit" && nodeB.name == "basket") {
            let shrink = SKAction.scale(to: 0, duration: 0.08)
            let removeNode = SKAction.removeFromParent()
            let sequence = SKAction.sequence([shrink,removeNode])
            if nodeA.name == "fruit" {
                nodeA.run(sequence)
            }
            else if nodeB.name == "fruit" {
                nodeB.run(sequence)
            }
            
            numCapFruits += 1
            currentScore.text = "Score: " + String(numCapFruits)
        }
        if (nodeA.name == "fruit" && nodeB.name == "ground") ||
            (nodeA.name == "ground" && nodeB.name == "fruit"){
            // Actual call for what happens when fruit hits ground
            // fruit.turnSpoiled()
            // Temporary substitute
            let shrink = SKAction.scale(to: 0, duration: 0.08)
            let removeNode = SKAction.removeFromParent()
            let sequence = SKAction.sequence([shrink,removeNode])
            let missedIndicator = UIImpactFeedbackGenerator(style: .medium)
            if nodeA.name == "fruit" {
                nodeA.run(sequence)
            }
            else if nodeB.name == "fruit" {
                nodeB.run(sequence)
            }
            
            lives -= 1
            livesLabel.text = "Lives: " + String(lives)
            missedIndicator.impactOccurred()
        }
        if (nodeA.name == "rotten" && nodeB.name == "ground") ||
            (nodeA.name == "ground" && nodeB.name == "rotten") {
            let shrink = SKAction.scale(to: 0, duration: 0.08)
            let removeNode = SKAction.removeFromParent()
            let sequence = SKAction.sequence([shrink,removeNode])
            if nodeA.name == "rotten" {
                nodeA.run(sequence)
            }
            else if nodeB.name == "rotten" {
                nodeB.run(sequence)
            }
        }
        if (nodeA.name == "rotten" && nodeB.name == "basket") ||
            (nodeA.name == "basket" && nodeB.name == "rotten") ||
            (nodeA.name == "rotten" && nodeB.name == "basketSideL") ||
            (nodeA.name == "basketSideL" && nodeB.name == "rotten") ||
            (nodeA.name == "rotten" && nodeB.name == "basketSideR") ||
            (nodeA.name == "basketSideR" && nodeB.name == "rotten") {
            let shrink = SKAction.scale(to: 0, duration: 0.08)
            let removeNode = SKAction.removeFromParent()
            let sequence = SKAction.sequence([shrink,removeNode])
            if nodeA.name == "rotten" {
                nodeA.run(sequence)
            }
            else if nodeB.name == "rotten" {
                nodeB.run(sequence)
            }
            
            lives -= 1
            livesLabel.text = "Lives: " + String(lives)
        }
    }
    
    func setUpPhysics() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3.0)
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
        let ground = SKSpriteNode(color: SKColor.green, size: CGSize(width: self.size.width, height: 175))
        ground.anchorPoint = CGPoint(x: 0, y: 0)
        ground.position = CGPoint(x: 0, y: 0)
        ground.zPosition = 1
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground.size.width, height: ground.size.height), center: CGPoint(x: self.size.width / 2, y: 175 / 2))
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.friction = 1.0
        ground.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
        ground.physicsBody?.contactTestBitMask = 6
        ground.name = "ground"
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
        // Load up player asset as white rectangle
        player = SKSpriteNode(color: SKColor.white, size: CGSize(width: 40, height: 100))
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
        // Set the player to have no collisions
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.categoryBitMask = 0
        // Add the player to the scene
        self.addChild(player)
    }
    
    func initializeBasket() {
        // Load up basket asset as red square
        basket = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 15, height: 5))
        // Set the basket's initial position and anchor point
        basket.position = CGPoint(x: 0, y: -5)
        // Set the basket's position to be in front of the player
        basket.zPosition = 2
        // Set the basket's name for identification
        basket.name = "basket"
        // Add physics body to the basket to interact with falling objects
        basket.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: basket.size.width, height: basket.size.height))
        // Turn off gravity for basket
        basket.physicsBody?.affectedByGravity = false
        // Don't allow fruits to move the basket
        basket.physicsBody?.isDynamic = false
        // Don't allow the basket to experience friction
        basket.physicsBody?.friction = 0.0
        // Set category for collision
        basket.physicsBody?.categoryBitMask = PhysicsCategory.basket.rawValue
        basket.physicsBody?.contactTestBitMask = 6
        
        player.addChild(basket)
        
        basketSideL = SKSpriteNode(color: SKColor.brown, size: CGSize(width: 10, height: 30))
        basketSideR = SKSpriteNode(color: SKColor.brown, size: CGSize(width: 10, height: 30))
        
        basketSideL.position = CGPoint(x: 25, y: 0)
        basketSideR.position = CGPoint(x: -25, y: 0)
        
        basketSideL.zPosition = 2
        basketSideR.zPosition = 2
        
        basketSideL.name = "basketSideL"
        basketSideR.name = "basketSideR"
        
        basketSideL.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: basketSideL.size.width, height: basketSideL.size.width))
        basketSideR.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: basketSideR.size.width, height: basketSideR.size.width))
        
        basketSideL.physicsBody?.affectedByGravity = false
        basketSideR.physicsBody?.affectedByGravity = false
        
        basketSideL.physicsBody?.isDynamic = false
        basketSideR.physicsBody?.isDynamic = false
        
        basketSideL.physicsBody?.friction = 0.0
        basketSideR.physicsBody?.friction = 0.0
        
        basketSideL.physicsBody?.categoryBitMask = PhysicsCategory.basketSide.rawValue
        basketSideR.physicsBody?.categoryBitMask = PhysicsCategory.basketSide.rawValue
        
        basketSideL.physicsBody?.contactTestBitMask = 6
        basketSideR.physicsBody?.contactTestBitMask = 6
        
        player.addChild(basketSideL)
        player.addChild(basketSideR)
        
        basketBottom = SKSpriteNode(color: SKColor.brown, size: CGSize(width: 60, height: 10))
        basketBottom.position = CGPoint(x: 0, y: -10)
        basketBottom.zPosition = 2
        basketBottom.name = "basketBottom"
        basketBottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: basketBottom.size.width, height: basketBottom.size.height))
        basketBottom.physicsBody?.affectedByGravity = false
        basketBottom.physicsBody?.isDynamic = false
        basketBottom.physicsBody?.friction = 0.0
        basketBottom.physicsBody?.categoryBitMask = PhysicsCategory.basketSide.rawValue
        basketBottom.physicsBody?.contactTestBitMask = 6
        
        player.addChild(basketBottom)
    }
    
    func startSpawner() {
        spawnFruit()
        spawnRotten()
    }
    
    private func spawnFruit() {
        let wait = SKAction.wait(forDuration: fruitDuration, withRange: 2)
        let spawn = SKAction.run {
            let fruit = Fruit(color: SKColor.yellow, size: CGSize(width: 40, height: 40))
            let xRange = 40...(self.size.width - 40)
            let xPos = CGFloat.random(in: xRange)
            fruit.position = CGPoint(x: xPos, y: self.size.height)
            self.addChild(fruit)
            self.fruits.append(fruit)
        }
        
        let sequence = SKAction.sequence([wait,spawn])
        self.run(SKAction.repeatForever(sequence))
    }
    
    private func spawnRotten() {
        let wait = SKAction.wait(forDuration: rottenDuration, withRange: 2)
        let spawn = SKAction.run {
            let rotten = Rotten(color: SKColor.black, size: CGSize(width: 40, height: 40))
            let xRange = 40...(self.size.width - 40)
            let xPos = CGFloat.random(in: xRange)
            rotten.position = CGPoint(x: xPos, y: self.size.height)
            self.addChild(rotten)
            self.rottens.append(rotten)
        }
        
        let sequence = SKAction.sequence([wait,spawn])
        self.run(SKAction.repeatForever(sequence))
    }
    
    private func removeFruit() {
        var indicesToRemove: [Int] = []
        
        for i in 0..<fruits.endIndex {
            if fruits[i].position.x < 0 || fruits[i].position.x > self.scene!.size.width {
                fruits[i].removeFromParent()
                indicesToRemove.append(i)
                
                lives -= 1
                livesLabel.text = "Lives: " + String(lives)
            }
        }
        
        for i in 0..<indicesToRemove.endIndex {
            fruits.remove(at: indicesToRemove[i])
        }
    }
}

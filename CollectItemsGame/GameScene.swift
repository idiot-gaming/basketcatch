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
    var ground: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        initializeUI()
        initializeBackground()
        initializeGround()
        initializePlayer()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    private func initializeUI() {
        // Steven can do UI
    }
    
    private func initializeBackground() {
        // Load up background asset
    }
    
    private func initializeGround() {
        // Load up ground asset for player to stand on
    }
    
    private func initializePlayer() {
        // Load up player asset
    }
}

//
//  TutorialScene.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/8/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//
import SpriteKit
import GameplayKit

class TutorialScene: GameScene {
    
    override func didMove(to view: SKView) {
        super.setUpPhysics()
        super.initializeUI()
        super.initializeBackground()
        super.initializePlayer()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

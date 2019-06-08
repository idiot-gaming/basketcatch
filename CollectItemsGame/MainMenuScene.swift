//
//  MainMenuScene.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/8/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    var playButton: SKShapeNode!
    var gameLogo: SKLabelNode!
    
    override func didMove(to view: SKView) {
        loadMainMenu()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if playButton.contains(location) {
                print("contains")
                self.startGame()
            }
        }
    }
    
    private func loadMainMenu() {
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner,bottomCorner,middle])
        
        playButton = SKShapeNode(path: path)
        playButton.zPosition = 1
        playButton.name = "play-button"
        playButton.position = CGPoint(x: 0, y: -50)
        playButton.fillColor = SKColor.cyan
        self.addChild(playButton)
        
        gameLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: 50)
        gameLogo.text = "Basket Catch"
        gameLogo.fontColor = SKColor.black
        self.addChild(gameLogo)
        
        self.backgroundColor = SKColor.white
    }
    
    private func startGame() {
        let gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fade(withDuration: 1)
        view!.presentScene(gameScene, transition: transition)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

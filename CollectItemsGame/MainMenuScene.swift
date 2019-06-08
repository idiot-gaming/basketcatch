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
    var tutorialButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        loadMainMenu()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if playButton.contains(location) {
                print("play")
                self.startGame()
            }
            else if tutorialButton.contains(location) {
                print("tutorial")
                self.startTutorial()
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
        playButton.position = CGPoint(x: 0, y: -200)
        playButton.fillColor = SKColor.cyan
        self.addChild(playButton)
        
        gameLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: 50)
        gameLogo.text = "Basket Catch"
        gameLogo.fontColor = SKColor.black
        self.addChild(gameLogo)
        
        tutorialButton = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        tutorialButton.zPosition = 1
        tutorialButton.position = CGPoint(x: 0, y: -75)
        tutorialButton.text = "Play Tutorial"
        tutorialButton.fontColor = SKColor.green
        self.addChild(tutorialButton)
        
        self.backgroundColor = SKColor.white
    }
    
    private func startGame() {
        let gameScene = GameScene(size: view!.bounds.size)
        let transition = SKTransition.fade(withDuration: 1)
        view!.presentScene(gameScene, transition: transition)
    }
    
    private func startTutorial() {
        let tutorialScene = TutorialScene(size: view!.bounds.size)
        let transition = SKTransition.fade(withDuration: 1)
        view!.presentScene(tutorialScene, transition: transition)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

//
//  SettingsScene.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/16/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//

import Foundation
import SpriteKit

class SettingsScene: SKScene {
    var languageMenu: SKSpriteNode!
    var languageBackButton: SKLabelNode!
    var languageSetting: SKLabelNode!
    var aboutLabel: SKLabelNode!
    var musicSetting: SKLabelNode?
    var soundSetting: SKLabelNode?
    
    override func didMove(to view: SKView) {
        initializeSettings()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            // let menuLocation: CGPoint? = touch.location(in: languageMenu)
            
            if languageSetting.contains(location) {
                self.initializeLanguageOptions()
                languageSetting.removeFromParent()
            }
            if languageBackButton.contains(location) {
                print("touched")
            }
            
//            if languageBackButton.contains(menuLocation!) {
//                self.removeLanguageOptions()
//                self.initializeSettings()
//            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    private func initializeSettings() {
        languageSetting = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        languageSetting.zPosition = 1
        languageSetting.position = CGPoint(x: size.width / 2, y: size.height / 2)
        languageSetting.text = "Language"
        languageSetting.fontColor = SKColor.black
        self.addChild(languageSetting)
        
//        aboutLabel = SKLabelNode(fontNamed: "ArialRoundedMTBold")
//        aboutLabel.zPosition = 1
//        aboutLabel.position = CGPoint(x: 0, y: -50)
//        aboutLabel.text = "About"
//        aboutLabel.fontColor = SKColor.black
//        self.addChild(aboutLabel)
        
        self.scene?.backgroundColor = SKColor.white
    }
    
    func initializeLanguageOptions() {
        languageMenu = SKSpriteNode(color: SKColor.gray, size: CGSize(width: 300, height: 400))
        languageMenu.zPosition = 2
        languageMenu.position = CGPoint(x: size.width / 2, y: size.height / 2)
        self.addChild(languageMenu)
        
        languageBackButton = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        languageBackButton.zPosition = 2
        languageBackButton.position = CGPoint(x: 0, y: 0)
        languageBackButton.text = "Back"
        languageBackButton.fontColor = SKColor.white
        languageMenu.addChild(languageBackButton)
    }
    
    func removeLanguageOptions() {
        languageMenu.removeFromParent()
        print("here")
    }
}

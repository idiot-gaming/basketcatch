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
        super.initializeBasket()
        displayStartTutorial()
    }
    
    private func displayStartTutorial() {
        /*
         Some UI for user to click through to display instructions
         Make sure user can only click "Next" on instructions so that
         they don't start gameplay until done reading instructions
        */
    }
}

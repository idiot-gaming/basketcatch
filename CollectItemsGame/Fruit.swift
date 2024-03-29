//
//  Fruit.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/8/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//

import Foundation
import SpriteKit

class Fruit: SKSpriteNode {
    var isIceFruit = false
    
    convenience init(color: UIColor, size: CGSize) {
        self.init(texture: nil, color: color, size: size)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        if color.isEqual(SKColor.white) {
            isIceFruit = true
        }
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        // Set up a basic physics body
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        // The fruits fall so obv affected by gravity
        self.physicsBody?.affectedByGravity = true
        // Turn off the friction
        self.physicsBody?.friction = 0.0
        // Make the fruits not bouncy
        self.physicsBody?.restitution = 0.3
        // Make sure that the sprites are rotating as they fall
        self.physicsBody?.angularVelocity = 10.0
        // Add the physics category to it
        self.physicsBody?.categoryBitMask = PhysicsCategory.fruit.value
        // Add the physics category for accepting collisions
        self.physicsBody?.collisionBitMask = PhysicsCategory.basket.value | PhysicsCategory.ground.value
        // self.physicsBody?.contactTestBitMask = PhysicsCategory.basket.value | PhysicsCategory.ground.value
        // Give a name to the fruit node
        if isIceFruit {
            self.name = "iceFruit"
        }
        else{
            self.name = "fruit"
        }
        // Put it farthest in the foreground
        self.zPosition = 2
    }
    
    func turnSpoiled() {
        // Function to trigger animation of fruit from fresh to spoiled and then disappear
        
    }
}

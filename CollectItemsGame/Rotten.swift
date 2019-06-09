//
//  Rotten.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/9/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//

import Foundation
import SpriteKit

class Rotten: SKSpriteNode {
    
    convenience init(color: UIColor, size: CGSize) {
        self.init(texture: nil, color: color, size: size)
        setup()
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.angularVelocity = 10.0
        self.name = "rotten"
        self.physicsBody?.categoryBitMask = PhysicsCategory.rotten.rawValue
        self.physicsBody?.contactTestBitMask = 9
        self.zPosition = 2
    }
}

//
//  Constants.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/9/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//

import Foundation
import SpriteKit

struct PhysicsCategory: OptionSet {
    let rawValue: UInt32
    
    init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    static let player = PhysicsCategory(rawValue: 0b0001)
    static let fruit = PhysicsCategory(rawValue: 0b0010)
    static let rotten = PhysicsCategory(rawValue: 0b0100)
    static let ground = PhysicsCategory(rawValue: 0b1000)
}

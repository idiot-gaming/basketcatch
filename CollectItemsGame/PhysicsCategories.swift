//
//  Constants.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/9/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//

import Foundation
import SpriteKit

enum PhysicsCategory: UInt32 {
    case basket
    case rotten
    case fruit
    case ground
    
    var value: UInt32 {
        switch self {
            case .basket: return UInt32(1)
            case .rotten: return UInt32(2)
            case .fruit: return UInt32(4)
            case .ground: return UInt32(8)
        }
    }
}

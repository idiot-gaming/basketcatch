//
//  FruitEnum.swift
//  CollectItemsGame
//
//  Created by Bryan Van Horn on 6/16/19.
//  Copyright © 2019 Bryan Van Horn. All rights reserved.
//

import Foundation
import SpriteKit

enum FruitColors: CaseIterable {
    case orange
    case yellow
    case blue
    case green
    case red
    case purple
    case ice
    
    var color: UIColor {
        switch self {
            case .red: return SKColor.red
            case .orange: return SKColor.orange
            case .yellow: return SKColor.yellow
            case .green: return SKColor.green
            case .blue: return SKColor.blue
            case .purple: return SKColor.purple
            case .ice: return SKColor.white
        }
    }
}

enum FruitSprite: String, CaseIterable {
    case Orange = "orange"
    case Plum = "plum"
    case Pineapple = "pineapple"
    case Avocado = "avocado"
    case Strawberry = "strawberry"
    case Blueberry = "blueberry"
    case Apple = "apple"
    case Kiwi = "kiwi"
    case Lemon = "lemon"
}

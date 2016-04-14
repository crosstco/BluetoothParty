//
//  RPSGame.swift
//  Bluetooth Party
//
//  Created by Colin on 4/13/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class RPSGame: Game {
    
    var selection : String = ""
    
    init() {
        super.init(name: "RPS", numPlayers: 2, viewController: RPSViewController())
    }
    
}

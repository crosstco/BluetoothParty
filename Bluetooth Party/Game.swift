//
//  Game.swift
//  Bluetooth Party
//
//  Created by Colin on 4/7/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class Game: NSObject {
    
    var name : String
    var numPlayers : Int
    var viewController : ViewController
    
    
    init(name : String, numPlayers : Int, viewController : ViewController) {
        
        self.name = name
        self.numPlayers = numPlayers
        self.viewController = viewController
    }

}

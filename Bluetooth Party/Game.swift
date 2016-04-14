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
    var viewController : UIViewController
    var players : [String] = []
    
    
    init(name : String, numPlayers : Int, viewController : UIViewController, players : [String])
    {
        
        self.name = name
        self.numPlayers = numPlayers
        self.viewController = viewController
    }
    
    override init()
    {
        self.name = ""
        self.numPlayers = 0
        players = []
        viewController = UIViewController()
    }

}

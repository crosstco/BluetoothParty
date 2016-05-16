//
//  MafiaViewController.swift
//  Bluetooth Party
//
//  Created by John Gadbois on 5/10/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class MafiaViewController: UIViewController
{
    var players : [String] = ["","","",""]
    var roles : [String] = ["","","",""]
    var game : Game = Game()
    var lobbyTitle : String = ""
    
    @IBOutlet weak var roleLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        assignRoles()
        roleLabel.text = roles [0] //change to each specific players roles
    }
    
    func assignRoles()
    {
        var index = 0
        while index < roles.count
        {
            roles[index] = "Civilian"
            index += 1
        }
        var mafia = Double(players.count) * 0.2
        var n : Double = 0.0
        while n < mafia
        {
            var random = arc4random_uniform(UInt32(roles.count))
            if (roles[Int(random)] == "Mafia")
            {
            }
            else
            {
                roles[Int(random)] = "Mafia"
                n += 1
            }
        }
    }
    
}

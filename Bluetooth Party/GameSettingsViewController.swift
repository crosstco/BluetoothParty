//
//  GameSettingsViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 4/7/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class GameSettingsViewController: UIViewController
{
    @IBOutlet weak var lobbyTitleTextField: UITextField!
    @IBOutlet weak var numberOfPlayersTextField: UITextField!
    @IBOutlet weak var playerNameTextField: UITextField!
    
    var game : Game = Game()
        
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        game.numPlayers = (numberOfPlayersTextField.text! as NSString).integerValue
        game.players.append(playerNameTextField.text!)
        let nextVC = segue.destinationViewController as! PlayerListViewController
        nextVC.lobbyTitle = lobbyTitleTextField.text!
        nextVC.game = game
    }
}

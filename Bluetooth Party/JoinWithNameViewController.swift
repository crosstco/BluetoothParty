//
//  JoinWithNameViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 4/7/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class JoinWithNameViewController: UIViewController {

    @IBOutlet weak var playerNameTextField: UITextField!
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let nextVC = segue.destinationViewController as! LobbyListViewController

        if playerNameTextField.text == nil {
            nextVC.playerName = UIDevice.currentDevice().name
            
        } else {
            nextVC.playerName = playerNameTextField.text!
        }
       
    }

}

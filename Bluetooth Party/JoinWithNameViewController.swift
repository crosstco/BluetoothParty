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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        playerNameTextField.placeholder = UIDevice.currentDevice().name
        
    }
    
    func dismissKeyboard() {
        playerNameTextField.resignFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        return true
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

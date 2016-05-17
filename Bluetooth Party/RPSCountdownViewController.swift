//
//  RPSCountdownViewController.swift
//  Bluetooth Party
//
//  Created by John Gadbois on 5/15/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class RPSCountdownViewController: UIViewController
{
    @IBOutlet weak var myLabel: UILabel!

    var count = 3
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        if(count > 0)
        {
            myLabel.text = String(count)
            --count
        }
        else
        {
            //segue to choose your weapon viewcontroller
        }
    }



}

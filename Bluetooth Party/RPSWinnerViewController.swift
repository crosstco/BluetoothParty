
//
//  RPSWinnerViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 5/16/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class RPSWinnerViewController: UIViewController {
    
    var winner: String!
    var timer: NSTimer!
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("update"), userInfo: nil, repeats: false)
    }

    
    func update() {
       
    
        performSegueWithIdentifier("WinnerToReady", sender: nil)
        
    }
    
}

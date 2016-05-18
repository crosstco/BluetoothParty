
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
    var game : Game!
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "update", userInfo: nil, repeats: false)
        if winner == "Tie"
        {
            winnerLabel.text = "Tie :|"
        }
        else if winner == "You"
        {
            winnerLabel.text = "You Win :)"
        }
        else
        {
            winnerLabel.text = "You opponent wins :("
        }
    }

    
    func update()
    {
       
    
        performSegueWithIdentifier("WinnerToReady", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let nextVC = segue.destinationViewController as! RPSWinnerViewController
        nextVC.game = game
    }
    
}

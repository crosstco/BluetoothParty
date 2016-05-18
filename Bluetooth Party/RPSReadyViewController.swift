//
//  RPSReadyViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 5/16/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class RPSReadyViewController: UIViewController
{
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    var seconds = 3
    
    var timer: NSTimer!
    var game : Game!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        seconds = 3
        numberLabel.text = "\(seconds)"
    }
    
    func update()
    {
        
        seconds -= 1
        
        var num = max(seconds, 0)
        numberLabel.text = "\(num)"
        
        if seconds <= 0 {
            
            performSegueWithIdentifier("ReadyToRPS", sender: nil)
        
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let VC = segue.destinationViewController as! RPSViewController
        
        VC.game = game
    }
    

}

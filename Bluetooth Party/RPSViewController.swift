//
//  RPSViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 4/13/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class RPSViewController: UIViewController
{
    var weaponString = ""
    
    @IBOutlet weak var paperText: UILabel!
    
    @IBOutlet weak var rockText: UILabel!
    
    @IBOutlet weak var scissText: UILabel!

    @IBOutlet weak var timingBar: UIProgressView!
    
    var seconds = 5
    var timer: NSTimer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        seconds = 5
        timingBar.progress = 1
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "update", userInfo: nil, repeats: true)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countDown", userInfo: nil, repeats: true)
        
    }
    
    func update() {
        
        
        var progress = timingBar.progress
        progress -= 0.02
        
        
        timingBar.progress = max(progress, 0)
    }
    
    func countDown() {
        seconds -= 1
        
        if seconds <= 0 {
            performSegueWithIdentifier("RPSToResult", sender: nil)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let VC = segue.destinationViewController as! RPS2ViewController
        
        VC.weaponString = self.weaponString
        
    }
    
    
    @IBAction func tapRock(sender: UIButton)
    {
        weaponString = rockText.text!
    }
    
    
    @IBAction func tapPaper(sender: UIButton)
    {
        weaponString = paperText.text!
    }
    
    
    @IBAction func tapSciss(sender: UIButton)
    {
        weaponString = scissText.text!
    }
    
}

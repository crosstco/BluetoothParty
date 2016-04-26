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

    override func viewDidLoad()
    {
        super.viewDidLoad()

        
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let nextVC = segue.destinationViewController as! RPS2ViewController
        nextVC.weaponString = weaponString
        
    }
    
    
    
    
    
}

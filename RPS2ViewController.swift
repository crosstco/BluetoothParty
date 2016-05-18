//
//  RPS2ViewController.swift
//  Bluetooth Party
//
//  Created by Alumme on 4/20/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class RPS2ViewController: UIViewController
{
    

    var weaponString: String!
    var opponentWeaponString = ""
    var timer: NSTimer!
    var seconds = 2
    var game : Game!
    var winner : String!
    
    @IBOutlet weak var opponentLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var yourView: UIView!
    @IBOutlet weak var cpuView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        seconds = 2
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        
        playerLabel.text = weaponString
        opponentLabel.text = opponentWeaponString
    }
    
    

    func update() {
        
         print("called")
        seconds -= 1
        
        if seconds <= 0 {
            
           
        performSegueWithIdentifier("ResultToWinner", sender: nil)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let nextVC = segue.destinationViewController as! RPSWinnerViewController
         nextVC.winner = determineWinner()
        nextVC.game = game
    }
    
    func determineWinner() -> String
    {
        if(weaponString == "🖐🏼" && opponentWeaponString == "👊🏼")
        {
            winner = "You"
        }
        else if(weaponString == "👊🏼" && opponentWeaponString == "✌🏼")
        {
            winner = "You"
        }
        else if(weaponString == "✌🏼" && opponentWeaponString == "🖐🏼")
        {
            winner = "You"
        }
        else if(weaponString == opponentWeaponString)
        {
            winner = "Tie"
        }
        else
        {
            winner = "Opponent"
        }
        return winner
    }

}
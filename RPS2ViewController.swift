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
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        seconds = 2
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
        
        //yourWeapon.text = weaponString
    }
    
    

    func update() {
        
         print("called")
        seconds -= 1
        
        if seconds <= 0 {
            
           
        performSegueWithIdentifier("ResultToWinner", sender: nil)
        }
        
    }
    
    
    @IBAction func tapForResult(sender: UIButton)
    {
        //youWin()
    }
    
    
    
    
//    func youWin()
//    {
//        if(yourWeapon.text == "🖐🏼" && cpuWeapon.text == "👊🏼")
//        {
//            yourView.backgroundColor = UIColor.greenColor()
//            cpuView.backgroundColor = UIColor.redColor()
//            let alert = UIAlertController(title: "Winner", message: "Nice Job!", preferredStyle: UIAlertControllerStyle.Alert)
//            let resetGame = UIAlertAction(title: "Play Again?", style: UIAlertActionStyle.Default, handler:
//                {sender in
//                    self.opponentWeaponString = ""
//                    self.cpuWeapon.text = ""
//                    self.yourView.backgroundColor = UIColor.whiteColor()
//                    self.cpuView.backgroundColor = UIColor.whiteColor()
//                    
//                    
//            })
//            alert.addAction(resetGame)
//            presentViewController(alert, animated: true, completion: nil)
//            
//        }
//        else if(yourWeapon.text == "👊🏼" && cpuWeapon.text == "✌🏼")
//        {
//            yourView.backgroundColor = UIColor.greenColor()
//            cpuView.backgroundColor = UIColor.redColor()
//            let alert = UIAlertController(title: "Winner!", message: "Nice Job!", preferredStyle: UIAlertControllerStyle.Alert)
//            let resetGame = UIAlertAction(title: "Play Again?", style: UIAlertActionStyle.Default, handler:
//                {sender in
//                    self.computerWeaponString = ""
//                    self.cpuWeapon.text = ""
//                    self.yourView.backgroundColor = UIColor.whiteColor()
//                    self.cpuView.backgroundColor = UIColor.whiteColor()
//                    
//            })
//            alert.addAction(resetGame)
//            presentViewController(alert, animated: true, completion: nil)
//            
//        }
//        else if(yourWeapon.text == "✌🏼" && cpuWeapon.text == "🖐🏼")
//        {
//            yourView.backgroundColor = UIColor.greenColor()
//            cpuView.backgroundColor = UIColor.redColor()
//            let alert = UIAlertController(title: "Winner!", message: "Nice Job!", preferredStyle: UIAlertControllerStyle.Alert)
//            let resetGame = UIAlertAction(title: "Play Again?", style: UIAlertActionStyle.Default, handler:
//                {sender in
//                    self.opponentWeaponString = ""
//                    self.cpuWeapon.text = ""
//                    self.yourView.backgroundColor = UIColor.whiteColor()
//                    self.cpuView.backgroundColor = UIColor.whiteColor()
//                    
//                    
//            })
//            alert.addAction(resetGame)
//            presentViewController(alert, animated: true, completion: nil)
//        }
//        else if( yourWeapon.text == cpuWeapon.text)
//        {
//            let alert = UIAlertController(title: "It's a tie!", message: "Computers can read minds... I wonder what's next.", preferredStyle: UIAlertControllerStyle.Alert)
//            let resetGame = UIAlertAction(title: "Play Again?", style: UIAlertActionStyle.Default, handler:
//                {sender in
//                    self.opponentWeaponString = ""
//                    self.cpuWeapon.text = ""
//                    self.yourView.backgroundColor = UIColor.whiteColor()
//                    self.cpuView.backgroundColor = UIColor.whiteColor()
//                    
//                    
//            })
//            alert.addAction(resetGame)
//            presentViewController(alert, animated: true, completion: nil)
//        }
//        else
//        {
//            yourView.backgroundColor = UIColor.redColor()
//            cpuView.backgroundColor = UIColor.greenColor()
//            let alert = UIAlertController(title: "You Lose :(", message: "You'll get 'em next time!", preferredStyle: UIAlertControllerStyle.Alert)
//            let resetGame = UIAlertAction(title: "Play Again?", style: UIAlertActionStyle.Default, handler:
//                {sender in
//                    self.opponentWeaponString = ""
//                    self.cpuWeapon.text = ""
//                    self.yourView.backgroundColor = UIColor.whiteColor()
//                    self.cpuView.backgroundColor = UIColor.whiteColor()
//                    
//                    
//                    
//            })
//            alert.addAction(resetGame)
//            presentViewController(alert, animated: true, completion: nil)
//        }
//        
//    }
//    
//    
//    
//    
//
}
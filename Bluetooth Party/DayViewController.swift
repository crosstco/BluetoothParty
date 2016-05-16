//
//  DayViewController.swift
//  Bluetooth Party
//
//  Created by John Gadbois on 5/10/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class DayViewController: UIViewController
{
    @IBOutlet weak var dayNumberLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!

    var dayNumber = 1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dayNumberLabel.text = "DAY " + String(dayNumber)
    }

}

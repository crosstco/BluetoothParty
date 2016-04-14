//
//  GameSelectionViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 4/7/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class GameSelectionViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    
    var duelingGames : [Game] = []
    var groupGames : [Game] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tabBar.delegate = self
        
        tabBar.selectedItem = tabBar.items![0]
        
        duelingGames.append(RPSGame())
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        tableView.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tabBar.selectedItem == tabBar.items![0]) {
            return duelingGames.count
            
        } else {
            return groupGames.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var array = []
        
        if(tabBar.selectedItem == tabBar.items![0]) {
            array = duelingGames
        } else {
            array = groupGames
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("gameCell", forIndexPath: indexPath)
        cell.textLabel?.text = array[indexPath.row].name //placeholder
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let nextVC = segue.destinationViewController as! GameSettingsViewController
        var array = []
        if(tabBar.selectedItem == tabBar.items![0]) {
            array = duelingGames
        } else {
            array = groupGames
        }
        let selectedRow = tableView.indexPathForSelectedRow?.row
        nextVC.game = array[selectedRow!] as! Game
    }
    
}

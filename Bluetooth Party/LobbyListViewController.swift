//
//  LobbyListViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 4/7/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit

class LobbyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var myTableView: UITableView!
    
    var lobbyTitle = ""
    var game : Game = Game()
    var playerName : String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1 //: replace 1 with number of lobbies
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let myCell = myTableView.dequeueReusableCellWithIdentifier("lobbyCell", forIndexPath: indexPath)
        myCell.textLabel?.text = "Lobby Title"
        lobbyTitle = (myCell.textLabel?.text)!
        myCell.detailTextLabel?.text = "Game Type"
        return myCell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        let nextVC = segue.destinationViewController as! PlayerListViewController
        nextVC.lobbyTitle = lobbyTitle
        
        
    }


}
//
//  LobbyListViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 4/7/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class LobbyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MatchmakingClientDelegate
{
    @IBOutlet weak var myTableView: UITableView!
    
    var lobbyTitle = ""
   
    var playerName : String!
    
    var matchmakingClient: MatchmakingClient!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        matchmakingClient.delegate = self
        
        matchmakingClient = MatchmakingClient(myPeerID: MCPeerID(displayName: playerName))
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return matchmakingClient.availableServerCount()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let myCell = myTableView.dequeueReusableCellWithIdentifier("lobbyCell", forIndexPath: indexPath)
        myCell.textLabel?.text = "Lobby Title"
        lobbyTitle = (myCell.textLabel?.text)!
        myCell.detailTextLabel?.text = "Game Type"
        return myCell
    }
    
    func matchmakingClient(client: MatchmakingClient, serverBecameAvailable peerID: MCPeerID)
    {
        myTableView.reloadData()
    }
    
    func matchmakingClient(client: MatchmakingClient, serverBecameUnavailable peerID: MCPeerID)
    {
        myTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let nextVC = segue.destinationViewController as! PlayerListViewController
        nextVC.game.players.append(playerName)
        nextVC.lobbyTitle = lobbyTitle
    }


}
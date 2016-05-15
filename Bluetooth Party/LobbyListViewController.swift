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
    
    var matchmakingClient: MatchmakingClient? = nil

    override func viewDidLoad()
    {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if(matchmakingClient == nil) {
            matchmakingClient = MatchmakingClient(name: playerName)
            matchmakingClient!.delegate = self
            matchmakingClient!.startSearchingForServersWithSessionID("btp-game")
            
            myTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if matchmakingClient != nil {
        return matchmakingClient!.availableServerCount()
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var myCell = myTableView.dequeueReusableCellWithIdentifier("lobbyCell", forIndexPath: indexPath)
        
        let peerID = matchmakingClient!.peerIDForAvailableServerAtIndex(indexPath.row)
        
        myCell.textLabel?.text = matchmakingClient!.displayNameForPeerID(peerID)
        
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
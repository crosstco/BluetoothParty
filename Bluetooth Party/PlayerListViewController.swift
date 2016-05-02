//
//  PlayerListViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 4/7/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class PlayerListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var myTableView: UITableView!
    
    var playerName: String = ""
    var lobbyTitle : String = ""
    var game : Game = Game()
    
    var matchmakingServer: MatchmakingServer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if matchmakingServer == nil {
            matchmakingServer = MatchmakingServer()
            matchmakingServer?.maxClients = 3
            matchmakingServer?.startAcceptingConnectionsForSessionID("btp-game")
            
            myTableView.reloadData()
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let myCell = myTableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath)
        myCell.textLabel?.text = game.players[indexPath.row]
        return myCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  0 //matchmakingServer.connectedClientCount()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let nextVC = segue.destinationViewController as! GameViewController
        nextVC.game = game
        nextVC.lobbyTitle = lobbyTitle
    }
    
}

//extension PlayerListViewController: MatchmakingServerDelegate {
//    
//    func matchmakingServer(server: MatchmakingServer, clientDidConnect peerID: MCPeerID) {
//        myTableView.reloadData()
//    }
//    
//    func matchmakingServer(server: MatchmakingServer, clientDidDisconnect peerID: MCPeerID) {
//        myTableView.reloadData()
//    }
//    
//}

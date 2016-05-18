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
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        if matchmakingServer == nil {
            matchmakingServer = MatchmakingServer()
            matchmakingServer!.delegate = self
            
            matchmakingServer?.maxClients = 3
            matchmakingServer?.startAcceptingConnectionsForSessionID("btp-game")
            
            myTableView.reloadData()
        }
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if matchmakingServer != nil {
            
            matchmakingServer?.endSession()
            matchmakingServer = nil
            
        }
}

    
    @IBAction func startGameAction(sender: AnyObject) {
        
        if matchmakingServer != nil && matchmakingServer.connectedClientCount() > 0 {
            
            matchmakingServer.stopAcceptingConnections()
            
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.myTableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath)
        let peerID = matchmakingServer?.peerIDForConnectedClientAtIndex(indexPath.row)
        
        cell.textLabel?.text = matchmakingServer?.displayNameForPeerID(peerID!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if matchmakingServer != nil {
            
            return matchmakingServer!.connectedClientCount()
            
        } else {
            return 0
        }

    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
//        let nextVC = segue.destinationViewController as! GameViewController
//        nextVC.game = game
//        nextVC.lobbyTitle = lobbyTitle
    }
    
}

extension PlayerListViewController: MatchmakingServerDelegate {
    
    func matchmakingServer(server: MatchmakingServer, clientDidConnect peerID: MCPeerID) {
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.myTableView.reloadData()
        }
    }
    
    func matchmakingServer(server: MatchmakingServer, clientDidDisconnect peerID: MCPeerID) {
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.myTableView.reloadData()
        }
    }
    
    func matchmakingServer(matchmakingServerSessionDidEnd server: MatchmakingServer) {
        
    }
    
}

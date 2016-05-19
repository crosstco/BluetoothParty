//
//  LobbyListViewController.swift
//  Bluetooth Party
//
//  Created by Colin on 4/7/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import MultipeerConnectivity

enum QuitReason {
    
    case NoNetwork
    case ConnectionDropped
    case UserQuit
    case ServerQuit
}

class LobbyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MatchmakingClientDelegate
{
    @IBOutlet weak var myTableView: UITableView!
    
    var lobbyTitle = ""
   
    var playerName : String!
    
    var matchmakingClient: MatchmakingClient? = nil
    
    var delegate: LobbyListViewControllerDelegate? = nil
    var quitReason: QuitReason!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        if(matchmakingClient == nil) {
            quitReason = .ConnectionDropped
            matchmakingClient = MatchmakingClient()
            matchmakingClient?.delegate = self
            matchmakingClient!.startSearchingForServersWithSessionID("btp-game")
            print("\(matchmakingClient?.clientState)")
            
            myTableView.reloadData()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        if matchmakingClient != nil {
            matchmakingClient?.disconnectFromServer()
            matchmakingClient = nil
        }
    }

    
    func showDisconnectionAlert() {
        let alert = UIAlertController(title: "Disconnected", message: "You were disconnected from the session.", preferredStyle: .Alert)
        let cancelButton = UIAlertAction(title: "OK", style: .Cancel) { (UIAlertAction) in
            
            self.dismissViewControllerAnimated(false, completion: nil)
            
        }
        
        alert.addAction(cancelButton)
        
        presentViewController(alert, animated: true, completion: nil)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if matchmakingClient != nil {
            let peerID = matchmakingClient?.peerIDForAvailableServerAtIndex(indexPath.row)
            matchmakingClient?.connectToServerWithPeerID(peerID!)
        }
    }
    
    
    func matchmakingClient(client: MatchmakingClient, serverBecameAvailable peerID: MCPeerID)
    {
        myTableView.reloadData()
    }
    
    func matchmakingClient(client: MatchmakingClient, serverBecameUnavailable peerID: MCPeerID)
    {
        myTableView.reloadData()
    }
    
    func matchmakingClient(client: MatchmakingClient, didDisconnectFromServer serverPeerID: MCPeerID) {
        matchmakingClient?.delegate = nil
        matchmakingClient = nil
        myTableView.reloadData()
        self.delegate?.lobbyListViewController(self, didDisconnectWithReason: quitReason)

    }
    
    func matchmakingClient(client: MatchmakingClient, didConnectToServer peerID: MCPeerID) {
        
        performSegueWithIdentifier("lobbyToReady", sender: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextVC = segue.destinationViewController as! RPSReadyViewController
        
        var game = Game()
        game.startClientGameWithSession((matchmakingClient?.session)!, playerName: UIDevice.currentDevice().name, serverPeerID: (matchmakingClient?.serverPeerID)!)
        
        nextVC.game = game
        
    }
}

extension LobbyListViewController: LobbyListViewControllerDelegate {
    
    func lobbyListViewController(lobbyListViewControllerDidCancel controller: LobbyListViewController) {
        
    }
    
    func lobbyListViewController(controller: LobbyListViewController, startGameWithSession session: MCSession) {
        
    }
    
    func lobbyListViewController(controller: LobbyListViewController, didDisconnectWithReason reason: QuitReason) {
        
        if reason == .ConnectionDropped {
            showDisconnectionAlert()
        }
        
    }
    
}



protocol LobbyListViewControllerDelegate {
    
    func lobbyListViewController(lobbyListViewControllerDidCancel controller: LobbyListViewController)
    func lobbyListViewController(controller: LobbyListViewController, didDisconnectWithReason reason: QuitReason)
    func lobbyListViewController(controller: LobbyListViewController, startGameWithSession session: MCSession)
    
}
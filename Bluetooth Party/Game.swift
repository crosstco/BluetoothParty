//
//  Game.swift
//  Bluetooth Party
//
//  Created by Colin on 4/7/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import MultipeerConnectivity

enum GameState {
    
    case WaitingForSignIn
    case WaitingForReady
    case Playing
    case GameOver
    case Quitting
    
}


protocol GameDelegate {
    
    func game(gameWaitingForServerReady game: Game)
}

class Game: NSObject {
    
    
    var delegate: GameDelegate? = nil
    var isServer: Bool!
    
    var gameState: GameState!
    var session: MCSession!
    var serverPeerID: MCPeerID? = nil
    var localPlayerName: NSString!
    
    var data: NSData? = nil
    
    var other: MCPeerID!
    
    var players: NSMutableDictionary!
    
    override init() {
        super.init()
        
        players = NSMutableDictionary(capacity: 2)
        
    }
    
    
    func startClientGameWithSession(session: MCSession, playerName: NSString, serverPeerID: MCPeerID) {
        self.isServer = false
        self.session = session
        self.session.delegate = self
        
        self.serverPeerID = serverPeerID
        self.localPlayerName = playerName
        
        self.other = serverPeerID
        
        self.gameState = .WaitingForSignIn
        
        self.delegate?.game(gameWaitingForServerReady: self)
    }
    
    func startServerGameWithSession(session: MCSession, playerName: NSString, client: MCPeerID) {
        self.isServer = true
        self.session = session
        self.session.delegate = self
        
        self.other = client
        self.localPlayerName = playerName
        
        
        self.gameState = .WaitingForSignIn
        
        self.delegate?.game(gameWaitingForServerReady: self)
        
    }
    
    func quitGameWithReason(reason: QuitReason) {
        
    }
    
    
}


extension Game: GameDelegate{
    
    func game(gameWaitingForServerReady game: Game) {
        
    }
}



extension Game: MCSessionDelegate {
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
        
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
        self.data = data
        
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    
    
    
    
}

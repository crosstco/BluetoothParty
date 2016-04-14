//
//  MatchmakingServer.swift
//  Bluetooth Party
//
//  Created by Colin on 4/14/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import GameKit
import MultipeerConnectivity

class MatchmakingServer: NSObject, MCSessionDelegate {
    
    var maxClients : Int
    var connectedClients = []
    var session : MCSession
    
    
    init(maxClients: Int, session: MCSession) {
        self.maxClients = maxClients
        self.session = session
        
        session.delegate = self
    }
    
    
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        <#code#>
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        <#code#>
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        <#code#>
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        <#code#>
    }
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        <#code#>
    }
}

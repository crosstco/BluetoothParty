//
//  MatchmakingServer.swift
//  SnapClone
//
//  Created by Colin on 4/28/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MatchmakingServer: NSObject {
    
    let serviceType = "btp-game"
    var peerID: MCPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
    
    var connectedClients: NSMutableArray!
    var maxClients: Int!
    var session: MCSession? = nil
    
    var serviceAdvertiser: MCNearbyServiceAdvertiser? = nil
    
    
    
    
    func startAcceptingConnectionsForSessionID(sessionID: String) {
        
        connectedClients = NSMutableArray(capacity: maxClients)
        session = MCSession(peer: peerID)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: sessionID)
        session!.delegate = self
        serviceAdvertiser?.delegate = self
        serviceAdvertiser?.startAdvertisingPeer()
    }
    
    func clientsConnected() -> NSArray {
        return connectedClients
    }
    
    
    
    
}

extension MatchmakingServer: MCSessionDelegate {
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    
}

extension MatchmakingServer: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        
    }
    
}


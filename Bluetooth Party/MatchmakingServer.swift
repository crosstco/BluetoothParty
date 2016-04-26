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

class MatchmakingServer: NSObject {
    
    var serverTitle : String
    var gameType : String
    var hostPeerID : MCPeerID
    
    var maxClients : Int
    var connectedClients = []
    var session : MCSession
    
    
    let serviceAdvertiser: MCNearbyServiceAdvertiser
    
    
    init(serverTitle : String, gameType : String, maxClients: Int, myPeerID: MCPeerID) {
        
        self.serverTitle = serverTitle
        self.gameType = gameType
        self.hostPeerID = myPeerID
        
        self.session = MCSession(peer: hostPeerID)
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: hostPeerID, discoveryInfo: nil, serviceType: "btp-game") //POI
        
        self.maxClients = maxClients
        
        
        super.init()
        
        serviceAdvertiser.delegate = self
        serviceAdvertiser.startAdvertisingPeer()
        
        session.delegate = self
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
    }
    
    
    
    func startAcceptingConnectionForSessionID(sessionID: String) {
        
        connectedClients = NSMutableArray(capacity: maxClients)
        session.delegate = self
        
    }
}

    
    extension MatchmakingServer: MCSessionDelegate {
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")

    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        NSLog("%@", "didFinishReceivingResourceWithName")

    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        NSLog("%@", "didFinishReceivingResourceWithName")

    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state)")
    }
}



extension MatchmakingServer: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        NSLog("%@", "didRecieveInformationFromPeer: \(peerID)")
    }
}

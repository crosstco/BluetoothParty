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


protocol MatchmakingServerDelegate {
    
    func matchmakingServer(server: MatchmakingServer, clientDidConnect peerID: MCPeerID)
    func matchmakingServer(server: MatchmakingServer, clientDidDisconnect peerID: MCPeerID)
}

enum ServerState {
    
    case ServerStateIdle
    case ServerStateAcceptingConnections
    case ServerStateIgnoringConnections
    
}


class MatchmakingServer: NSObject {
    
    var serverTitle : String
    var gameType : String
    var hostPeerID : MCPeerID
    
    var maxClients : Int
    var connectedClients: NSMutableArray
    var session : MCSession
    
    var serverState: ServerState
    
    var delegate: MatchmakingServerDelegate? = nil
    
    
    let serviceAdvertiser: MCNearbyServiceAdvertiser
    
    
    init(serverTitle : String, gameType : String, maxClients: Int, myPeerID: MCPeerID) {
        
        self.serverTitle = serverTitle
        self.gameType = gameType
        self.hostPeerID = myPeerID
        
        self.session = MCSession(peer: hostPeerID)
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: hostPeerID, discoveryInfo: nil, serviceType: "btp-game") //POI
        
        self.maxClients = maxClients
        
        self.serverState = .ServerStateIdle
        
        self.connectedClients = NSMutableArray(capacity: maxClients)
        
        super.init()
        
        serviceAdvertiser.delegate = self
        serviceAdvertiser.startAdvertisingPeer()
        
        session.delegate = self
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
    }
    
    
    
    func startAcceptingConnectionForSessionID(sessionID: String) {
        
        if serverState == .ServerStateIdle {
        connectedClients = NSMutableArray(capacity: maxClients)
        session.delegate = self
        }
    }
    
    func connectedClientCount() -> Int {
        return connectedClients.count
    }
    
    func peerIDForConnectedClientAtIndex(index: Int) -> MCPeerID {
        return connectedClients[index] as! MCPeerID
    }
    
    func displayNameForPeerID(peerID: MCPeerID) -> String {
        return peerID.displayName
    }
}


    
    extension MatchmakingServer: MCSessionDelegate {
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {


    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {


    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {


    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {

    }
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
        if state == .Connected {
        if serverState == .ServerStateAcceptingConnections {
            if !connectedClients.containsObject(peerID) {
                connectedClients.addObject(peerID)
                self.delegate!.matchmakingServer(self, clientDidConnect: peerID)
                
            }
            
            }
        }
        
        if state == .NotConnected {
            if serverState != .ServerStateIdle {
             
                if connectedClients.containsObject(peerID) {
                    connectedClients.removeObject(peerID)
                    self.delegate!.matchmakingServer(self, clientDidDisconnect: peerID)
                    
                }
                
            }
    }
}
}



extension MatchmakingServer: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        
        if (serverState == .ServerStateAcceptingConnections) && (connectedClientCount() < maxClients) {
            invitationHandler(true, session)
        }
    }
}

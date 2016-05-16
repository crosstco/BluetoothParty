//
//  MatchmakingServer.swift
//  SnapClone
//
//  Created by Colin on 4/28/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import MultipeerConnectivity

protocol MatchmakingServerDelegate {
    
    func matchmakingServer(server: MatchmakingServer, clientDidConnect peerID: MCPeerID)
    
    func matchmakingServer(server: MatchmakingServer, clientDidDisconnect peerID: MCPeerID)
    
    func matchmakingServer(matchmakingServerSessionDidEnd server: MatchmakingServer)
    
}

enum ServerState {
    case Idle
    case AcceptingConnections
    case IgnoringNewConnections
}


class MatchmakingServer: NSObject {
    
    let serviceType = "btp-game"
    var peerID: MCPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
    
    
    var connectedClients: NSMutableArray!
    var maxClients: Int!
    var session: MCSession? = nil
    
    var serviceAdvertiser: MCNearbyServiceAdvertiser? = nil
    
    var serverState: ServerState!
    
    var delegate: MatchmakingServerDelegate? = nil
    
    override init() {
        serverState = .Idle
    }
    
    func startAcceptingConnectionsForSessionID(sessionID: String) {
        
        if serverState == .Idle {
            
            serverState = .AcceptingConnections
            
            connectedClients = NSMutableArray(capacity: maxClients)
            session = MCSession(peer: peerID)
            serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: sessionID)
            session!.delegate = self
            serviceAdvertiser?.delegate = self
            serviceAdvertiser?.startAdvertisingPeer()
        }
    }
    
    func endSession() {
        
        serverState = .Idle
        
        session?.disconnect()
        session?.delegate = nil
        
        session = nil
        
        connectedClients = nil
        
        delegate?.matchmakingServer(matchmakingServerSessionDidEnd: self)
        
    }
    
    
    func clientsConnected() -> NSArray {
        return connectedClients
    }
    
    func connectedClientCount() -> Int {
        return connectedClients.count
    }
    
    func peerIDForConnectedClientAtIndex(index: Int) -> MCPeerID {
        return connectedClients.objectAtIndex(index) as! MCPeerID
    }
    
    func displayNameForPeerID(peerID: MCPeerID) -> String {
        return peerID.displayName
    }
    
    
    
    
}

extension MatchmakingServer: MCSessionDelegate {
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            print("peer changed state")
            
            
            switch state {
                
                
            case .Connected:
                print("\(peerID.displayName) connected")
                
                if(self.serverState == .AcceptingConnections) {
                    if !self.connectedClients.containsObject(peerID) {
                        self.connectedClients.addObject(peerID)
                        self.delegate?.matchmakingServer(self, clientDidConnect: peerID)
                        
                    }
                }
                
                print("\(session.connectedPeers)")
                
                break
                
                
            case .Connecting:
                print("client conencting")
                break
                
            case .NotConnected:
                if(self.serverState != .Idle) {
                    if self.connectedClients.containsObject(peerID) {
                        self.connectedClients.removeObject(peerID)
                        self.delegate?.matchmakingServer(self, clientDidDisconnect: peerID)
                    }
                }
                break
                
            default:
                break
                
            }
            
            
        }
        
        
        
    }
    
    func session(session: MCSession, didReceiveCertificate certificate: [AnyObject]?, fromPeer peerID: MCPeerID, certificateHandler: (Bool) -> Void) {
        certificateHandler(true)
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
        
        if serverState == .AcceptingConnections && connectedClientCount() < maxClients {
            
            invitationHandler(true, self.session!)
            
        }
        
        
        
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        
    }
    
    
}

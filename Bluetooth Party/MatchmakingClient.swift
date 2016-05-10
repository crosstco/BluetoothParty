//
//  MatchmakingClient.swift
//  Bluetooth Party
//
//  Created by Colin on 4/14/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import GameKit

protocol MatchmakingClientDelegate {
    
    func matchmakingClient(client: MatchmakingClient, serverBecameAvailable peerID: MCPeerID)
    
    func matchmakingClient(client: MatchmakingClient, serverBecameUnavailable peerID: MCPeerID)
}

enum ClientState {
    
    case ClientStateIdle
    case ClientStateSearchingForServers
    case ClientStateConnecting
    case ClientStateConnected
    
}

class MatchmakingClient: NSObject {
    
    let serviceType = "btp-game"
    
    var session: MCSession
    var availableServers: NSMutableArray
    let serviceBrowser: MCNearbyServiceBrowser
    
    var delegate: MatchmakingClientDelegate? = nil
    
     var clientState: ClientState
    
    
    
    init(myPeerID: MCPeerID) {
        
        session = MCSession(peer: myPeerID)
        availableServers = NSMutableArray(capacity: 10)
        clientState = .ClientStateIdle
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        
        super.init()
        
        serviceBrowser.startBrowsingForPeers()
    }
    deinit {
        serviceBrowser.stopBrowsingForPeers()
    }
    
    
    func connectToServerWithPeerID(peerID: MCPeerID) {
    
        clientState = .ClientStateConnecting
        let serverPeerID = peerID
        
        serviceBrowser.invitePeer(serverPeerID, toSession: session, withContext: nil, timeout: 10)

    }
    
    
    func startSearchingForServersWithSessionID(sessionID: String) { //stub method
        if clientState == .ClientStateIdle {
            clientState = .ClientStateSearchingForServers
        }
    }
    
    
    func availableServerCount() -> Int {
        return availableServers.count
    }
    
    func peerIDForAvailableServerAtIndex(index: Int) -> MCPeerID {
        return availableServers.objectAtIndex(index) as! MCPeerID
    }
    
    func displayNameForPeerID(peerID: MCPeerID) -> String {
        return peerID.displayName
    }
    
    
}

//extension MatchmakingClient: MatchmakingClientDelegate {
//    
//    func matchmakingClient(client: MatchmakingClient, serverBecameAvailable peerID: MCPeerID) {
//        
//    }
//    
//    func matchmakingClient(client: MatchmakingClient, serverBecameUnavailable peerID: MCPeerID) {
//        
//    }
//    
//}

extension MatchmakingClient: MCSessionDelegate {
    
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
}

extension MatchmakingClient: MCNearbyServiceBrowserDelegate {
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        
    }
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        if clientState == .ClientStateSearchingForServers {
        
        if !availableServers.containsObject(peerID) {
            availableServers.addObject(peerID)
            
            self.delegate!.matchmakingClient(self, serverBecameAvailable: peerID)
            }

        }
        
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
        if clientState == .ClientStateSearchingForServers {
        
        if availableServers.containsObject(peerID) {
            availableServers.removeObject(peerID)
            
            self.delegate!.matchmakingClient(self, serverBecameUnavailable: peerID)
            }
        }
    }
}
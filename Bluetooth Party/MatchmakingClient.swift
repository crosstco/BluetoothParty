//
//  MatchmakingClient.swift
//  SnapClone
//
//  Created by Colin on 4/16/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import MultipeerConnectivity

protocol MatchmakingClientDelegate {
    
    func matchmakingClient(client: MatchmakingClient, serverBecameAvailable peerID: MCPeerID)
    
    func matchmakingClient(client: MatchmakingClient, serverBecameUnavailable peerID: MCPeerID)
}

class MatchmakingClient: NSObject {
    
    var peerID: MCPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
    
    var availableServers: NSMutableArray!
    var session: MCSession? = nil
    
    var browser: MCNearbyServiceBrowser? = nil
    
    
    var delegate: MatchmakingClientDelegate? = nil
    
    
    init(name: String) {
        peerID = MCPeerID(displayName: name)
    }
    
    
    func startSearchingForServersWithSessionID(sessionID: String) {
        
        availableServers = NSMutableArray(capacity: 10)
        session = MCSession(peer: peerID)
        browser = MCNearbyServiceBrowser(peer: peerID, serviceType: sessionID)
        browser?.delegate = self
        browser?.startBrowsingForPeers()
        
    }
    
    func serversAvailable() -> NSArray {
        return availableServers!
    }
    
    func availableServerCount() -> Int {
        return availableServers.count
    }
    
    func peerIDForAvailableServerAtIndex(index: Int) -> MCPeerID {
        return availableServers.objectAtIndex(index) as! MCPeerID
    }
    
    func displayNameForPeerID(peerID: MCPeerID) -> String {
        print(peerID.displayName)
        return  peerID.displayName
    }
    
}


extension MatchmakingClient: MCSessionDelegate {
    
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

extension MatchmakingClient: MCNearbyServiceBrowserDelegate {
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        if !availableServers!.containsObject(peerID) {
            availableServers?.addObject(peerID)
            print("\(availableServers[0])")
            delegate?.matchmakingClient(self, serverBecameAvailable: peerID)
            print("FoundPeerInternally")
            
        }
        print("FoundPeer")
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
        if availableServers!.containsObject(peerID) {
            availableServers!.removeObject(peerID)
            delegate?.matchmakingClient(self, serverBecameUnavailable: peerID)
        }
        
        print("LostPeer")
    }
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        print("Not browsing")
        
    }
    
}

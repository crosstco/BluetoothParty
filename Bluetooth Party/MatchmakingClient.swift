//
//  MatchmakingClient.swift
//  SnapClone
//
//  Created by Colin on 4/29/16.
//  Copyright © 2016 Bluetooth Party Development Team. All rights reserved.
//

import UIKit
import MultipeerConnectivity

protocol MatchmakingClientDelegate {
    
    func matchmakingClient(client: MatchmakingClient, serverBecameAvailable peerID: MCPeerID)
    
    func matchmakingClient(client: MatchmakingClient, serverBecameUnavailable peerID: MCPeerID)
    
    func matchmakingClient(client: MatchmakingClient, didDisconnectFromServer serverPeerID: MCPeerID)
    
    func matchmakingClient(client: MatchmakingClient, didConnectToServer peerID: MCPeerID)
}

enum ClientState {
    case Idle
    case SearchingForServers
    case Connecting
    case Connected
}

class MatchmakingClient: NSObject {
    
    var peerID: MCPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
    
    var serverPeerID: MCPeerID? = nil
    var session: MCSession? = nil
    
    var availableServers: NSMutableArray!
    
    var browser: MCNearbyServiceBrowser? = nil
    
    var clientState: ClientState
    
    
    var delegate: MatchmakingClientDelegate? = nil
    
    override init() {
        clientState = .Idle
    }
    
    
    
    func startSearchingForServersWithSessionID(sessionID: String) {
        
        if clientState == .Idle {
            
            clientState = .SearchingForServers
            
            session = MCSession(peer: peerID)
            availableServers = NSMutableArray(capacity: 10)
            browser = MCNearbyServiceBrowser(peer: peerID, serviceType: sessionID)
            session!.delegate = self
            browser?.delegate = self
            browser?.startBrowsingForPeers()
        }
        
    }
    
    
    func connectToServerWithPeerID(peerID: MCPeerID) {
        clientState = .Connecting
        serverPeerID = peerID
        browser?.invitePeer(serverPeerID!, toSession: session!, withContext: nil, timeout: 30)
    }
    
    func disconnectFromServer() {
        
        clientState = .Idle
        
        session?.disconnect()
        session?.delegate = nil
        
        session = nil
        
        availableServers = nil
        
        if serverPeerID != nil {
            delegate?.matchmakingClient(self, didDisconnectFromServer: serverPeerID!)
            serverPeerID = nil
        }
        
        
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
        
        if serverPeerID != nil && peerID == serverPeerID {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            print("host changed state")
            
            switch state {
                
            case .Connected:
                if self.clientState == .Connecting {
                    self.clientState = .Connected
                    self.delegate?.matchmakingClient(self, didConnectToServer: peerID)
                    
                }
                break
                
            case .NotConnected:
                
                print("Disconnected")
                
                if self.clientState == .Connected || self.clientState == .Connecting {
                    self.disconnectFromServer()
                }
                
                break
                
            default:
                break
            }
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

extension MatchmakingClient: MCNearbyServiceBrowserDelegate {
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        if clientState == .SearchingForServers {
            
            if !availableServers!.containsObject(peerID) {
                availableServers?.addObject(peerID)
                delegate?.matchmakingClient(self, serverBecameAvailable: peerID)
            }
            
        }
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
        print("Made it here")
        print("\(clientState)")
        
        if clientState == .SearchingForServers {
            
            
            if availableServers!.containsObject(peerID) {
                availableServers!.removeObject(peerID)
                delegate?.matchmakingClient(self, serverBecameUnavailable: peerID)
            }
        }
    }
    
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        print("Not browsing")
        
    }
    
}

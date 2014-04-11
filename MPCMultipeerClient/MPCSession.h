//
//  MPCSession.h
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

@import MultipeerConnectivity.MCSession;
#import "MPCPeerObject.h"

@protocol MPCSessionDelegate <NSObject>

- (void)peerObject:(MPCPeerObject *)peerObject connectingToPeer:(MCPeerID *)peerID;

- (void)peerObject:(MPCPeerObject *)peerObject connectedToPeer:(MCPeerID *)peerID;

- (void)peerObject:(MPCPeerObject *)peerObject disconnectedFromPeer:(MCPeerID *)peerID;

- (void)peerObject:(MPCPeerObject *)peerObject didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID;

@end

@interface MPCSession : MPCPeerObject <MCSessionDelegate>

@property (weak) id<MPCSessionDelegate> delegate;
@property (strong, readonly) MCSession *session;
@property (strong, readonly) NSString *sessionID;

@end

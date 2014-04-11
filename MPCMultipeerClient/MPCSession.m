//
//  MPCSession.m
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "MPCSession.h"

@implementation MPCSession

- (id)initWithDisplayName:(NSString *)displayName {
    self = [super initWithDisplayName:displayName];
    if (self) {
        _session = [[MCSession alloc] initWithPeer:self.myPeerID];
        self.session.delegate = self;
    }
    return self;
}

#pragma mark - MCSessionDelegate

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    if (![peerID.displayName isEqualToString:self.myPeerID.displayName] && self.delegate) {
        switch (state) {
            case MCSessionStateConnecting:
                [self.delegate peerObject:self connectingToPeer:peerID];
                break;
                
            case MCSessionStateConnected:
                [self.delegate peerObject:self connectedToPeer:peerID];
                break;
                
            case MCSessionStateNotConnected:
                [self.delegate peerObject:self disconnectedFromPeer:peerID];
                break;
        }
    }
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    [self.delegate peerObject:self didReceiveData:data fromPeer:peerID];
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    // No-op
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    // No-op
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    // No-op
}

@end

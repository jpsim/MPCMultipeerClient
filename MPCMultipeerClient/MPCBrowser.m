//
//  MPCBrowser.m
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

@import MultipeerConnectivity.MCNearbyServiceBrowser;
#import "MPCBrowser.h"

@interface MPCBrowser () <MCNearbyServiceBrowserDelegate>

@property (strong, readonly) MCNearbyServiceBrowser *browser;

@end

@implementation MPCBrowser

- (void)startBrowsingWithServiceType:(NSString *)serviceType {
    _browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.myPeerID serviceType:serviceType];
    self.browser.delegate = self;
    [self.browser startBrowsingForPeers];
}

#pragma mark - MCNearbyServiceBrowserDelegate

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    if (![peerID.displayName isEqualToString:self.myPeerID.displayName]) {
        [browser invitePeer:peerID toSession:self.session withContext:nil timeout:30];
    }
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    // No-op
}

@end

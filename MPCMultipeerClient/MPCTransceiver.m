//
//  MPCTransceiver.m
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "MPCTransceiver.h"
#import "MPCAdvertiser.h"
#import "MPCBrowser.h"
#import "MPCNotifications.h"

@interface MPCTransceiver () {
    MPCAdvertiser *_advertiser;
    MPCBrowser *_browser;
}

@property (nonatomic, assign, readwrite) MPCTransceiverMode transceiverMode;
@property (nonatomic, strong, readonly) MPCAdvertiser *advertiser;
@property (nonatomic, strong, readonly) MPCBrowser *browser;

@end

@implementation MPCTransceiver

#pragma mark - Public API

- (void)startTransceivingWithServiceType:(NSString *)serviceType discoveryInfo:(NSDictionary *)info {
    [self.advertiser startAdvertisingWithServiceType:serviceType discoveryInfo:info];
    [self.browser startBrowsingWithServiceType:serviceType];
    self.transceiverMode = MPCTransceiverModeTransceiver;
}

- (void)startAdvertisingWithServiceType:(NSString *)serviceType discoveryInfo:(NSDictionary *)info {
    [self.advertiser startAdvertisingWithServiceType:serviceType discoveryInfo:info];
    self.transceiverMode = MPCTransceiverModeHost;
}

- (void)startBrowsingWithServiceType:(NSString *)serviceType {
    [self.browser startBrowsingWithServiceType:serviceType];
    self.transceiverMode = MPCTransceiverModeJoin;
}

#pragma mark - Helpers

- (void)publish:(NSString *)eventName peerObject:(MPCPeerObject *)peerObject peerID:(MCPeerID *)peerID {
    [self publish:eventName peerObject:peerObject peerID:peerID data:nil];
}

- (void)publish:(NSString *)eventName peerObject:(MPCPeerObject *)peerObject peerID:(MCPeerID *)peerID data:(NSData *)data {
    NSMutableDictionary *payload = [NSMutableDictionary dictionaryWithDictionary:@{kMPCMyPeerIDKey: peerObject.myPeerID,
                                                                                   kMPCPeerIDKey: peerID}];
    if (data) [payload addEntriesFromDictionary:@{kMPCDataKey: data}];
    [[NSNotificationCenter defaultCenter] postNotificationName:eventName object:payload.copy];
}

- (MCSession *)sessionConnectedToPeer:(MCPeerID *)peerID {
    for (MCPeerID *peer in self.advertiser.session.connectedPeers) {
        if (peer.displayName == peerID.displayName) {
            return self.advertiser.session;
        }
    }

    for (MCPeerID *peer in self.browser.session.connectedPeers) {
        if (peer.displayName == peerID.displayName) {
            return self.browser.session;
        }
    }
    
    return nil;
}

#pragma mark - Getters

- (NSString *)displayName {
    return [[UIDevice currentDevice] name];
}

- (MPCAdvertiser *)advertiser {
    if (!_advertiser) {
        _advertiser = [[MPCAdvertiser alloc] initWithDisplayName:[self displayName]];
        _advertiser.delegate = self;
    }
    return _advertiser;
}

- (MPCBrowser *)browser {
    if (!_browser) {
        _browser = [[MPCBrowser alloc] initWithDisplayName:[self displayName]];
        _browser.delegate = self;
    }
    return _browser;
}

#pragma mark - MPCSessionDelegate

- (void)peerObject:(MPCPeerObject *)peerObject connectingToPeer:(MCPeerID *)peerID {
    [self publish:kMPCConnectingWithPeerNotification peerObject:peerObject peerID:peerID];
}

- (void)peerObject:(MPCPeerObject *)peerObject connectedToPeer:(MCPeerID *)peerID {
    [self publish:kMPCConnectedToPeerNotification peerObject:peerObject peerID:peerID];
}

- (void)peerObject:(MPCPeerObject *)peerObject disconnectedFromPeer:(MCPeerID *)peerID {
    [self publish:kMPCDisconnectedFromPeerNotification peerObject:peerObject peerID:peerID];
}

- (void)peerObject:(MPCPeerObject *)peerObject didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    [self publish:kMPCReceivedDataFromPeerNotification peerObject:peerObject peerID:peerID data:data];
}

@end

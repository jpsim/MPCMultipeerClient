//
//  MPCMultipeerClient.h
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

@import Foundation;
@import MultipeerConnectivity;

typedef void(^MPCPeerBlock)(MCPeerID *peerID);
typedef void(^MPCEventBlock)(MCPeerID *peerID, NSString *event, id object);
typedef void(^MPCObjectBlock)(MCPeerID *peerID, id object);

@interface MPCMultipeerClient : NSObject

// Advertise/Browse
+ (void)advertiseWithServiceType:(NSString *)serviceType;
+ (void)browseWithServiceType:(NSString *)serviceType;

// Blocks
+ (void)onConnect:(MPCPeerBlock)block;
+ (void)onDisconnect:(MPCPeerBlock)block;
+ (void)onEvent:(NSString *)event runBlock:(MPCObjectBlock)block;

+ (void)removeBlockForEvent:(NSString *)event;
+ (void)removeAllEventBlocks;

// Properties
+ (MCSession *)session;

// Events
+ (void)sendEvent:(NSString *)event withObject:(id)object;
+ (void)sendEvent:(NSString *)event withObject:(id)object toPeers:(NSArray *)peers;

@end

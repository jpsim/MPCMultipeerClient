//
//  MPCMultipeerClient.m
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "MPCMultipeerClient.h"
#import "MPCTransceiver.h"
#import "MPCNotifications.h"

@interface MPCMultipeerClient ()

@property (nonatomic, strong) MPCTransceiver *transceiver;
@property (nonatomic, strong) MCSession *session;

@property (nonatomic, strong) NSMutableDictionary *eventBlocks;

@property (nonatomic, copy) MPCPeerBlock onConnect;
@property (nonatomic, copy) MPCPeerBlock onDisconnect;
@property (nonatomic, copy) MPCEventBlock onEvent;
@property (nonatomic, copy) MPCObjectBlock onEventObject;

@end

@implementation MPCMultipeerClient

#pragma mark - Singleton

+ (instancetype)sharedClient {
    static MPCMultipeerClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MPCMultipeerClient alloc] init];
        _sharedClient.transceiver = [[MPCTransceiver alloc] init];
        _sharedClient.eventBlocks = [[NSMutableDictionary alloc] init];
        [_sharedClient addObservers];
    });
    
    return _sharedClient;
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserverForName:kMPCConnectedToPeerNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.onConnect(note.object[kMPCPeerIDKey]);
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:kMPCDisconnectedFromPeerNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.onDisconnect(note.object[kMPCPeerIDKey]);
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:kMPCReceivedDataFromPeerNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:note.object[kMPCDataKey]];
        self.onEvent(note.object[kMPCPeerIDKey], dict[@"event"], dict[@"object"]);
    }];
}

#pragma mark - Advertise/Browse

+ (void)advertiseWithServiceType:(NSString *)serviceType {
    [[[MPCMultipeerClient sharedClient] transceiver] startAdvertisingWithServiceType:serviceType discoveryInfo:nil];
}

+ (void)browseWithServiceType:(NSString *)serviceType {
    [[[MPCMultipeerClient sharedClient] transceiver] startBrowsingWithServiceType:serviceType];
}

#pragma mark - Blocks

+ (void)onConnect:(MPCPeerBlock)block {
    [[self sharedClient] setOnConnect:block];
}

+ (void)onDisconnect:(MPCPeerBlock)block {
    [[self sharedClient] setOnDisconnect:block];
}

+ (void)onEvent:(MPCEventBlock)block {
    [[self sharedClient] setOnEvent:block];
}

- (MPCPeerBlock)onConnect {
    __weak typeof(self)weakSelf = self;
    MPCPeerBlock onConnect = ^(MCPeerID *peerID){
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            if (!strongSelf.session) {
                strongSelf.session = [strongSelf.transceiver sessionConnectedToPeer:peerID];
            }
            if (strongSelf->_onConnect) strongSelf->_onConnect(peerID);
        });
    };
    return onConnect;
}

- (MPCPeerBlock)onDisconnect {
    __weak typeof(self)weakSelf = self;
    MPCPeerBlock onDisconnect = ^(MCPeerID *peerID){
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            if (strongSelf->_onDisconnect) strongSelf->_onDisconnect(peerID);
        });
    };
    return onDisconnect;
}

- (MPCEventBlock)onEvent {
    __weak typeof(self)weakSelf = self;
    MPCEventBlock onEvent = ^(MCPeerID *peerID, NSString *event, id object){
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            @synchronized(strongSelf){
                MPCObjectBlock block = strongSelf.eventBlocks[event];
                if (block) block(peerID, object);
            }
        });
    };
    return onEvent;
}

+ (void)onEvent:(NSString *)event runBlock:(MPCObjectBlock)block {
    @synchronized([self sharedClient]){
        [[[self sharedClient] eventBlocks] addEntriesFromDictionary:@{event: block}];
    }
}

+ (void)removeBlockForEvent:(NSString *)event {
    @synchronized([self sharedClient]){
        [[[self sharedClient] eventBlocks] removeObjectForKey:event];
    }
}

+ (void)removeAllEventBlocks {
    @synchronized([self sharedClient]){
        [[[self sharedClient] eventBlocks] removeAllObjects];
    }
}

#pragma mark - Properties

+ (MCSession *)session {
    return [[self sharedClient] session];
}

#pragma mark - Events

+ (void)sendEvent:(NSString *)event withObject:(id)object {
    [self sendEvent:event withObject:object toPeers:[[[MPCMultipeerClient sharedClient] session] connectedPeers]];
}

+ (void)sendEvent:(NSString *)event withObject:(id)object toPeers:(NSArray *)peers {
    NSDictionary *rootObject = object ? @{@"event": event, @"object": object} : @{@"event": event};
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rootObject];
    NSError *error = nil;
    [[[self sharedClient] session] sendData:data toPeers:peers withMode:MCSessionSendDataReliable error:&error];
}

@end

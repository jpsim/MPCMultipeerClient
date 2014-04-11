//
//  MPCTransceiver.h
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

@import Foundation;
#import "MPCSession.h"

typedef enum {
    MPCTransceiverModeUnknown = 0,
    MPCTransceiverModeHost = 1,
    MPCTransceiverModeJoin = 2,
    MPCTransceiverModeTransceiver = 3
} MPCTransceiverMode;

@interface MPCTransceiver : NSObject <MPCSessionDelegate>

@property (nonatomic, readonly) MPCTransceiverMode transceiverMode;

- (void)startTransceivingWithServiceType:(NSString *)serviceType discoveryInfo:(NSDictionary *)info;

- (void)startAdvertisingWithServiceType:(NSString *)serviceType discoveryInfo:(NSDictionary *)info;

- (void)startBrowsingWithServiceType:(NSString *)serviceType;

- (MCSession *)sessionConnectedToPeer:(MCPeerID *)peerID;

@end

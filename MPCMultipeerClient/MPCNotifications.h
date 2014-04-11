//
//  MPCNotifications.h
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

@import Foundation;

extern NSString *const kMPCConnectingWithPeerNotification;
extern NSString *const kMPCConnectedToPeerNotification;
extern NSString *const kMPCDisconnectedFromPeerNotification;
extern NSString *const kMPCReceivedDataFromPeerNotification;

extern NSString *const kMPCMyPeerIDKey;
extern NSString *const kMPCPeerIDKey;
extern NSString *const kMPCDataKey;

@interface MPCNotifications : NSObject

@end

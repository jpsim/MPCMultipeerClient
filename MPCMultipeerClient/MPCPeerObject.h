//
//  MPCPeerObject.h
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

@import Foundation;
@import MultipeerConnectivity.MCPeerID;

@interface MPCPeerObject : NSObject

@property (strong, readonly) MCPeerID *myPeerID;

- (id)initWithDisplayName:(NSString *)displayName;

@end

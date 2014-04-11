//
//  MPCPeerObject.m
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "MPCPeerObject.h"

@implementation MPCPeerObject

- (id)initWithDisplayName:(NSString *)displayName {
    self = [super init];
    if (self) {
        _myPeerID = [[MCPeerID alloc] initWithDisplayName:displayName];
    }
    return self;
}

@end

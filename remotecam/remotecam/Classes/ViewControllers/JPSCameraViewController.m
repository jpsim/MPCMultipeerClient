//
//  JPSCameraViewController.m
//  remotecam
//
//  Created by JP Simard on 2014-04-10.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "JPSCameraViewController.h"
#import "MPCMultipeerClient.h"

@interface JPSCameraViewController ()

@end

@implementation JPSCameraViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [MPCMultipeerClient advertiseWithServiceType:@"remotecam"];
    __weak typeof(self)weakSelf = self;
    [MPCMultipeerClient onConnect:^(MCPeerID *peerID) {
        // :)
    }];
    [MPCMultipeerClient onDisconnect:^(MCPeerID *peerID) {
        // :(
    }];
    [MPCMultipeerClient onEvent:@"takePicture" runBlock:^(MCPeerID *peerID, id object) {
        JPSCameraViewController *strongSelf = weakSelf;
        [strongSelf performSelector:@selector(takePicture)];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MPCMultipeerClient removeBlockForEvent:@"takePicture"];
}

@end

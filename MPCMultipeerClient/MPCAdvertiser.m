//
//  MPCAdvertiser.m
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

@import MultipeerConnectivity.MCNearbyServiceAdvertiser;
#import "MPCAdvertiser.h"

@interface MPCAdvertiser () <MCNearbyServiceAdvertiserDelegate>

@property (strong, readonly) MCNearbyServiceAdvertiser *advertiser;

@end

@implementation MPCAdvertiser

- (void)startAdvertisingWithServiceType:(NSString *)serviceType discoveryInfo:(NSDictionary *)discoveryInfo {
    _advertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.myPeerID 
                                                    discoveryInfo:discoveryInfo 
                                                      serviceType:serviceType];
    
    self.advertiser.delegate = self;
    [self.advertiser startAdvertisingPeer];
}

#pragma mark - MCNearbyServiceAdvertiserDelegate

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler {
    invitationHandler(YES, self.session);
}

@end

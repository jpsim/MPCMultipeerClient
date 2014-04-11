//
//  MPCAdvertiser.h
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "MPCSession.h"

@interface MPCAdvertiser : MPCSession

- (void)startAdvertisingWithServiceType:(NSString *)serviceType discoveryInfo:(NSDictionary *)discoveryInfo;

@end

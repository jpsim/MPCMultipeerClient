//
//  MPCBrowser.h
//  MPCMultipeerClient
//
//  Created by JP Simard on 4/3/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "MPCSession.h"

@interface MPCBrowser : MPCSession

- (void)startBrowsingWithServiceType:(NSString *)serviceType;

@end

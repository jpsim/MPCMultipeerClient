//
//  JPSAppDelegate.m
//  remotecam
//
//  Created by JP Simard on 4/11/14
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "JPSAppDelegate.h"
#import "JPSMainViewController.h"

@implementation JPSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[JPSMainViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

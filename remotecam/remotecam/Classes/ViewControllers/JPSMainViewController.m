//
//  JPSMainViewController.m
//  remotecam
//
//  Created by JP Simard on 2014-04-10.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "JPSMainViewController.h"
#import "JPSCameraViewController.h"
#import "JPSRemoteViewController.h"

@interface JPSMainViewController ()

@end

@implementation JPSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"remotecam";
    [self setupUI];
}

#pragma mark - UI

- (void)setupUI {
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setupCameraButton];
    [self setupRemoteButton];
}

- (void)setupCameraButton {
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cameraButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:cameraButton];
    [cameraButton setTitle:@"Camera" forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(launchCamera) forControlEvents:UIControlEventTouchUpInside];
    
    // Constraints
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:cameraButton
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.0f];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:cameraButton
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0f
                                                                constant:0.0f];
    [self.view addConstraints:@[centerX, centerY]];
}

- (void)setupRemoteButton {
    UIButton *remoteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    remoteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:remoteButton];
    [remoteButton setTitle:@"Remote" forState:UIControlStateNormal];
    [remoteButton addTarget:self action:@selector(launchRemote) forControlEvents:UIControlEventTouchUpInside];
    
    // Constraints
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:remoteButton
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.0f];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:remoteButton
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0f
                                                                constant:60.0f];
    [self.view addConstraints:@[centerX, centerY]];
}

#pragma mark - Actions

- (void)launchCamera {
    [self presentViewController:[[JPSCameraViewController alloc] init] animated:YES completion:nil];
}

- (void)launchRemote {
    [self.navigationController pushViewController:[[JPSRemoteViewController alloc] init] animated:YES];
}

@end

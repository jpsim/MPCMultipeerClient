//
//  JPSRemoteViewController.m
//  remotecam
//
//  Created by JP Simard on 2014-04-10.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "JPSRemoteViewController.h"
#import "MPCMultipeerClient.h"

@interface JPSRemoteViewController ()

@end

@implementation JPSRemoteViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [MPCMultipeerClient browseWithServiceType:@"remotecam"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Remote";
    [self setupUI];
}

#pragma mark - UI

- (void)setupUI {
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setupTakePictureButton];
}

- (void)setupTakePictureButton {
    UIButton *takePictureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    takePictureButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:takePictureButton];
    [takePictureButton setTitle:@"Take Picture" forState:UIControlStateNormal];
    [takePictureButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    // Constraints
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:takePictureButton
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.0f];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:takePictureButton
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0f
                                                                constant:0.0f];
    [self.view addConstraints:@[centerX, centerY]];
}

#pragma mark - Actions

- (void)takePicture {
    [MPCMultipeerClient sendEvent:@"takePicture" withObject:nil];
}

@end

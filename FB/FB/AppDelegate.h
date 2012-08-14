//
//  AppDelegate.h
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import <FacebookSDK/FacebookSDK.h>




extern NSString *const FBSessionStateChangedNotification;




@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;


- (BOOL) openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void) closeSession;


@end

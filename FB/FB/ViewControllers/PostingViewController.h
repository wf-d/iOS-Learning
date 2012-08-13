//
//  PostingViewController.h
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Common.h"




@interface PostingViewController : UIViewController


@property (retain, nonatomic) IBOutlet UITextField *labelName;
@property (retain, nonatomic) IBOutlet UITextField *labelMessage;
@property (retain, nonatomic) IBOutlet UIButton *buttonPost;
@property (retain, nonatomic) IBOutlet UIButton *buttonAuth;
@property (retain, nonatomic) IBOutlet UITextField *fieldName;
@property (retain, nonatomic) IBOutlet UITextField *fieldMessage;


- (IBAction)clickedPost:(id)sender;
- (IBAction)clickedAuth:(id)sender;


@end

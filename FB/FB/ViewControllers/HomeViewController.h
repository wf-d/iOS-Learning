//
//  HomeViewController.h
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "PostingViewController.h"
#import "FriendListViewController.h"



@class PostingViewController;
@class FriendListViewController;




@interface HomeViewController : UIViewController
{
    PostingViewController *postingViewController;
    FriendListViewController *friendListViewController;
}


@property (retain, nonatomic) IBOutlet UIButton *buttonAuth;

- (IBAction)clickedAuth:(id)sender;
- (IBAction)clickedPostToFeed:(id)sender;
- (IBAction)clickedFriends:(id)sender;


@end

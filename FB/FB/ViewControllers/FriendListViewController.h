//
//  FriendListViewController.h
//  FB
//
//  Created by Nikita Rosenberg on 8/14/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "Common.h"
#import "User.h"




@interface FriendListViewController : UIViewController
<UITableViewDataSource,
UITableViewDelegate>
{
    NSMutableArray *friends;
}


@property (assign, nonatomic) NSUInteger currentPage;

@property (retain, nonatomic) IBOutlet UITableView *tableViewFriends;
@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;


- (void) loadPage:(NSUInteger)page;
- (void) showFriendsCount;


@end

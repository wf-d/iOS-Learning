//
//  HomeViewController.h
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "PostingViewController.h"




@interface HomeViewController : UIViewController
{
    PostingViewController *postingViewController;
}


- (IBAction)clickedPostToFeed:(id)sender;


@end

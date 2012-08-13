//
//  PostingViewController.h
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import <UIKit/UIKit.h>




@interface PostingViewController : UIViewController


@property (retain, nonatomic) NSString *testProperty;

@property (retain, nonatomic) IBOutlet UITextField *labelName;
@property (retain, nonatomic) IBOutlet UITextField *labelMessage;

- (IBAction)clickedPost:(id)sender;

@end

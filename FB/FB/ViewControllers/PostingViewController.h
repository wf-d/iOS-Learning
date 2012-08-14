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
<UITextFieldDelegate,
UITextFieldDelegate>
{
    id currentFirstResponder;
}


@property (retain, nonatomic) NSMutableDictionary *params;

@property (retain, nonatomic) IBOutlet UITextField *fieldMessage;
@property (retain, nonatomic) IBOutlet UITextField *fieldLink;
@property (retain, nonatomic) IBOutlet UITextField *fieldCaption;
@property (retain, nonatomic) IBOutlet UITextView *fieldDescription;

@property (retain, nonatomic) IBOutlet UIButton *buttonPost;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


- (IBAction)clickedPost:(id)sender;

- (void) resetDescriptionField;


@end

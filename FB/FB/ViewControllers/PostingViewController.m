//
//  PostingViewController.m
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import "PostingViewController.h"




@implementation PostingViewController


#pragma mark - Synthesize


@synthesize testProperty = _testProperty;
@synthesize labelName = _labelName;
@synthesize labelMessage = _labelMessage;




#pragma mark - Lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }

    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
}




- (void)viewDidUnload
{
    [self setLabelName:nil];
    [self setLabelMessage:nil];

    [super viewDidUnload];
}




- (void)dealloc
{
    [_labelName release];
    [_labelMessage release];

    [super dealloc];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark - Setters


- (void) setTestProperty:(NSString *)testProperty
{
    if ( testProperty != _testProperty )
    {
        [_testProperty release];
        _testProperty = testProperty;
        [_testProperty retain];
    }
}




#pragma mark - Actions


- (IBAction)clickedPost:(id)sender
{
    
}




@end

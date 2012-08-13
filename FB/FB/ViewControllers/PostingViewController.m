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


@synthesize labelName = _labelName;
@synthesize labelMessage = _labelMessage;
@synthesize buttonPost = _buttonPost;
@synthesize buttonAuth = _buttonAuth;
@synthesize fieldName = _fieldName;
@synthesize fieldMessage = _fieldMessage;




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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionStateChanged:)
                                                 name:FBSessionStateChangedNotification
                                               object:nil];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
}




- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self setLabelName:nil];
    [self setLabelMessage:nil];
    [self setButtonPost:nil];
    [self setButtonAuth:nil];

    [self setFieldName:nil];
    [self setFieldMessage:nil];
    [super viewDidUnload];
}




- (void)dealloc
{
    [_labelName release];
    [_labelMessage release];
    [_buttonPost release];
    [_buttonAuth release];

    [_fieldName release];
    [_fieldMessage release];
    [super dealloc];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark - Setters







#pragma mark - Actions


- (IBAction)clickedPost:(id)sender
{
    if ( [self.fieldName.text isEqualToString:@""] || [self.fieldMessage.text isEqualToString:@""] )
    {
        [Common showAlertWithTitle:@"Error" andMessage:@"Fill all fileds."];
    }
}




- (IBAction)clickedAuth:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ( FBSession.activeSession.isOpen )
    {
        [appDelegate closeSession];
    }
    else
    {
        // The user has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
}




#pragma mark - Facebook


- (void)sessionStateChanged:(NSNotification*)notification
{
    if ( FBSession.activeSession.isOpen )
    {
        [self.buttonAuth setTitle:@"Logout" forState:UIControlStateNormal];
    }
    else
    {
        [self.buttonAuth setTitle:@"Login" forState:UIControlStateNormal];
    }
}




#pragma mark - Touches


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ( [self.labelName isFirstResponder] && self.labelName != touch.view )
    {
        [self.labelName resignFirstResponder];
    }
    else if ( [self.labelMessage isFirstResponder] && self.labelMessage != touch.view )
    {
        [self.labelMessage resignFirstResponder];
    }
}



@end

//
//  HomeViewController.m
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import "HomeViewController.h"




@implementation HomeViewController


#pragma mark - Synthesize


@synthesize buttonAuth;




#pragma mark - Lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Home";
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
    
    [[Common appDelegate] openSessionWithAllowLoginUI:NO];
}




- (void)viewDidUnload
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self setButtonAuth:nil];

    [super viewDidUnload];
}




- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self trigUiAccordingToSession];
}




- (void) viewWillDisappear:(BOOL)animated
{    
    [super viewWillDisappear:animated];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




- (void)dealloc
{
    [postingViewController release];
    [buttonAuth release];
    
    [super dealloc];
}




#pragma mark - UI Helpers


- (void) trigUiAccordingToSession
{
    if ( FBSession.activeSession.isOpen )
    {
        [self.buttonAuth setTitle:@"Logout" forState:UIControlStateNormal];
        
        for ( UIButton *btn in self.view.subviews )
        {
            if ( btn.tag == 0 )
            {
                btn.enabled = YES;
            }
        }
        //self.buttonPost.enabled = YES;
    }
    else
    {
        [self.buttonAuth setTitle:@"Login" forState:UIControlStateNormal];
        //self.buttonPost.enabled = NO;
        for ( UIButton *btn in self.view.subviews )
        {
            if ( btn.tag == 0 )
            {
                btn.enabled = NO;
            }
        }
    }
}




#pragma mark - Facebook


- (void) sessionStateChanged:(NSNotification*)notification
{
    [self trigUiAccordingToSession];
}




#pragma mark - Actions


- (IBAction)clickedAuth:(id)sender
{
    AppDelegate *appDelegate = [Common appDelegate];
    if ( FBSession.activeSession.isOpen )
    {
        [appDelegate closeSession];
    }
    else
    {
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
}




- (IBAction)clickedPostToFeed:(id)sender
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        postingViewController = [[PostingViewController alloc] init];
    });
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"self.fieldMessage.text" forKey:@"message"];
    [params setValue:@"http://ya.ru" forKey:@"link"];
    [params setValue:@"self.fieldCaption.text" forKey:@"caption"];
    [params setValue:@"self.fieldDescription.text" forKey:@"description"];
    postingViewController.params = params;
    
    [self.navigationController pushViewController:postingViewController animated:YES];
}




- (IBAction)clickedFriends:(id)sender 
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        friendListViewController = [[FriendListViewController alloc] init];
    });
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"self.fieldMessage.text" forKey:@"message"];
    [params setValue:@"http://ya.ru" forKey:@"link"];
    [params setValue:@"self.fieldCaption.text" forKey:@"caption"];
    [params setValue:@"self.fieldDescription.text" forKey:@"description"];
    //friendListViewController.params = params;
    
    [self.navigationController pushViewController:friendListViewController animated:YES];
}




@end

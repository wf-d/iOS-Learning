//
//  PostingViewController.m
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import "PostingViewController.h"




NSString *const kPlaceholderPostMessage = @"Say something about this...";




@implementation PostingViewController


#pragma mark - Synthesize


@synthesize params = _params;
@synthesize buttonPost = _buttonPost, buttonAuth = _buttonAuth;
@synthesize fieldMessage = _fieldMessage, fieldLink = _fieldLink, fieldCaption = _fieldCaption, fieldDescription = _fieldDescription;




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
    
    if ( !self.params )
    {
        self.params = [[NSMutableDictionary alloc] init];
    }
        
    
    self.fieldMessage.text = [self.params valueForKey:@"message"];
    self.fieldLink.text = [self.params valueForKey:@"link"];
    self.fieldCaption.text = [self.params valueForKey:@"caption"];
    self.fieldDescription.text = [self.params valueForKey:@"description"];
    
    if ( [self.fieldDescription.text isEqualToString:@""] )
    {
        [self resetDescriptionField];
    }
    
    [self trigUiAccordingToSession];
}




- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self setButtonPost:nil];
    [self setButtonAuth:nil];
    [self setFieldMessage:nil];
    [self setFieldDescription:nil];
    [self setFieldLink:nil];
    [self setFieldCaption:nil];
    
    [super viewDidUnload];
}




- (void)dealloc
{
    [_params release];
    [_buttonPost release];
    [_buttonAuth release];
    [_fieldMessage release];
    [_fieldDescription release];
    [_fieldLink release];
    [_fieldCaption release];
    
    [super dealloc];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




#pragma mark - UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentFirstResponder = textField;
}




- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ( currentFirstResponder == textField )
    {
        currentFirstResponder = nil;
    }
    
    return YES;
}



- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if ( textField == self.fieldMessage )
    {
        [self.fieldLink becomeFirstResponder];
    }
    else if ( textField == self.fieldLink )
    {
        [self.fieldCaption becomeFirstResponder];
    }
    else if ( textField == self.fieldCaption )
    {
        [self.fieldDescription becomeFirstResponder];
    }
    
    return YES;
}




#pragma mark - UITextViewDelegate


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    currentFirstResponder = textView;
    
    if ( [textView.text isEqualToString:kPlaceholderPostMessage] )
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}




- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ( [textView.text isEqualToString:@""] )
    {
        [self resetDescriptionField];
    }
}




#pragma mark - UI Helpers


- (void) resetDescriptionField
{
    self.fieldDescription.text = kPlaceholderPostMessage;
    self.fieldDescription.textColor = [UIColor lightGrayColor];    
}




- (void) trigUiAccordingToSession
{
    if ( FBSession.activeSession.isOpen )
    {
        [self.buttonAuth setTitle:@"Logout" forState:UIControlStateNormal];
        self.buttonPost.enabled = YES;
    }
    else
    {
        [self.buttonAuth setTitle:@"Login" forState:UIControlStateNormal];
        self.buttonPost.enabled = NO;
    }
}




#pragma mark - Actions


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




- (IBAction)clickedPost:(id)sender
{
    if (    [self.fieldMessage.text isEqualToString:@""] ||
            [self.fieldLink.text isEqualToString:@""] ||
            [self.fieldCaption.text isEqualToString:@""] ||
            ([self.fieldDescription.text isEqualToString:kPlaceholderPostMessage]) )
    {
        [Common showAlertWithTitle:@"Error" andMessage:@"Fill all fileds."];
        
        return;
    }
    
    
    [self.params setValue:self.fieldMessage.text forKey:@"message"];
    [self.params setValue:self.fieldLink.text forKey:@"link"];
    [self.params setValue:self.fieldCaption.text forKey:@"caption"];
    [self.params setValue:self.fieldDescription.text forKey:@"description"];
    
    
    
    [FBRequestConnection startWithGraphPath:@"me/feed"
                                 parameters:self.params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
    {
        NSString *alertText;
        if ( error )
        {
            alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
        }
        else
        {
            alertText = [NSString stringWithFormat:@"Posted action, id: %@", [result objectForKey:@"id"]];
        }
        
        [Common showAlertWithTitle:@"Result" andMessage:alertText];
    }];
}




#pragma mark - Facebook


- (void) sessionStateChanged:(NSNotification*)notification
{
    [self trigUiAccordingToSession];
}




#pragma mark - Touches


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ( currentFirstResponder != touch.view )
    {
        [currentFirstResponder resignFirstResponder];
        currentFirstResponder = nil;
    }
}




@end

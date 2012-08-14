//
//  HomeViewController.m
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import "HomeViewController.h"




@implementation HomeViewController




#pragma mark - Lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




- (void)dealloc
{
    [postingViewController release];
    
    [super dealloc];
}




#pragma mark - Actions


- (IBAction)clickedPostToFeed:(id)sender
{
    /*
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        postingViewController = [[PostingViewController alloc] init];
        
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setValue:@"self.fieldMessage.text" forKey:@"message"];
        [params setValue:@"http://ya.ru" forKey:@"link"];
        [params setValue:@"self.fieldCaption.text" forKey:@"caption"];
        [params setValue:@"self.fieldDescription.text" forKey:@"description"];
        postingViewController.params = params;
    });
    
    [self.navigationController pushViewController:postingViewController animated:YES];
     */
}




@end

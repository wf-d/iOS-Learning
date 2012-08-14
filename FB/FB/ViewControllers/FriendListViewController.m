//
//  FriendListViewController.m
//  FB
//
//  Created by Nikita Rosenberg on 8/14/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import "FriendListViewController.h"




@implementation FriendListViewController


#pragma mark - Synthesize


@synthesize tableViewFriends;
@synthesize activityIndicator;




#pragma mark - Lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"Friends";
    }
    
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
}




- (void)viewDidUnload
{
    [self setTableViewFriends:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
}




- (void) viewWillAppear:(BOOL)animated
{    
    [self.activityIndicator startAnimating];
    
    
    [FBRequestConnection startWithGraphPath:@"me/friends"
                                 parameters:nil 
                                 HTTPMethod:@"GET" 
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
    {
       
        
        NSString *alertText;
        if ( error )
        {
            alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
            NSLog(@"%@", alertText);
            NSLog(@"accessToken: %@", FBSession.activeSession.accessToken);
        }
        else
        {
            friends = [NSMutableArray new];
            
            for ( NSDictionary *dict in [result valueForKey:@"data"] )
            {
                User *friend = [[User alloc] initWithDictionary:dict];
                [friends addObject:friend];
                [friend release];
            }
        
            
            [self.tableViewFriends reloadData];
            [self.activityIndicator stopAnimating];
        }
        
        //[Common showAlertWithTitle:@"Result" andMessage:alertText];
    }];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




- (void)dealloc
{
    [tableViewFriends release];
    [activityIndicator release];

    [super dealloc];
}




#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [friends count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusubleIdentifier = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusubleIdentifier];
    
    if ( cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusubleIdentifier];
        cell.textLabel.text = [[friends objectAtIndex:indexPath.row] name];
        cell.detailTextLabel.text =  [Common stringFromLongLong:[[friends objectAtIndex:indexPath.row] userId]];
    }
    
    return cell;    
}




#pragma mark - UITableViewDelegate

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
}
*/



@end

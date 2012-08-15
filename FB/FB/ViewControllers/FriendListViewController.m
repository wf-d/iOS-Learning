//
//  FriendListViewController.m
//  FB
//
//  Created by Nikita Rosenberg on 8/14/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import "FriendListViewController.h"




NSUInteger const itemsPerPage = 10; 




@implementation FriendListViewController


#pragma mark - Synthesize

@synthesize currentPage = _currentPage;
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
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    CGFloat offset = (self.navigationController.navigationBar.frame.size.height-self.activityIndicator.frame.size.height) * 0.5;
    self.activityIndicator.frame = CGRectMake(
                                              self.navigationController.navigationBar.frame.size.width - self.activityIndicator.frame.size.width - offset,
                                              offset,
                                              self.activityIndicator.frame.size.width,
                                              self.activityIndicator.frame.size.height);
    
    self.activityIndicator.hidesWhenStopped = YES;
    [self.activityIndicator release];
    
    [self.navigationController.navigationBar addSubview:self.activityIndicator];
}




- (void)viewDidUnload
{
    [self setTableViewFriends:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
}




- (void) viewWillAppear:(BOOL)animated
{    
    [self showFriendsCount];
    self.currentPage = 0;
}




- (void) viewDidDisappear:(BOOL)animated
{
    [friends removeAllObjects];
    [self.tableViewFriends reloadData];
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




#pragma mark - UI Helpers


- (void) setCurrentPage:(NSUInteger)currentPage
{
    _currentPage = currentPage;
    [self loadPage:_currentPage];
}




#pragma mark - Facebook


- (void) loadPage:(NSUInteger)page
{   
    [self.activityIndicator startAnimating];
    
    
    if ( page == 0 )
    {
         friends = [NSMutableArray new];
    }
    
    
    NSString *graphPath = [NSString stringWithFormat:@"me/friends?limit=%u&offset=%u", itemsPerPage, page*itemsPerPage];
    
    [FBRequestConnection startWithGraphPath:graphPath
                                 parameters:nil 
                                 HTTPMethod:@"GET" 
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
     {
         if ( error )
         {
             NSString *alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
             NSLog(@"%@", alertText);
             NSLog(@"accessToken: %@", FBSession.activeSession.accessToken);
             [Common showAlertWithTitle:@"Result" andMessage:alertText];
         }
         else
         {        
             NSMutableArray *indexPaths = [NSMutableArray new];
             
             for ( NSUInteger i = 0; i < [[result valueForKey:@"data"] count]; i++ )
             {
                 NSDictionary *dict = [[result valueForKey:@"data"] objectAtIndex:i];
                 User *friend = [[User alloc] initWithDictionary:dict];
                 [friends addObject:friend];
                 [friend release];
                 [indexPaths addObject:[NSIndexPath indexPathForRow:self.currentPage*itemsPerPage+i inSection:0]];
             }
             
             [self.tableViewFriends insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
             [self.activityIndicator stopAnimating];
         }
     }];
}




- (void) showFriendsCount
{
    NSString *graphPath = @"fql";
    NSString *fqlQuery = @"SELECT friend_count FROM user WHERE uid = me()";
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            fqlQuery, @"q",
                            nil];
    
    [FBRequestConnection startWithGraphPath:graphPath
                                 parameters:params 
                                 HTTPMethod:@"GET" 
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
    {
        [params release];
        
        if ( error )
        {
            NSString *alertText = [NSString stringWithFormat:@"error: domain = %@, code = %d", error.domain, error.code];
            NSLog(@"%@", alertText);
            NSLog(@"accessToken: %@", FBSession.activeSession.accessToken);
            [Common showAlertWithTitle:@"Result" andMessage:alertText];
        }
        else
        {
            NSString *friendsCount = [[[result valueForKey:@"data"] objectAtIndex:0] valueForKey:@"friend_count"];
            self.title = [NSString stringWithFormat:@"Friends (%@)", friendsCount];
        }
    }];
}




#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [friends count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusableIdentifier = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if ( cell == nil )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusableIdentifier];
    }
    
    cell.textLabel.text = [[friends objectAtIndex:indexPath.row] name];
    cell.detailTextLabel.text =  [Common stringFromLongLong:[[friends objectAtIndex:indexPath.row] userId]];
    
    return cell;    
}




#pragma mark - UITableViewDelegate

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96.0f;
}
*/




- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}




- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == self.currentPage*itemsPerPage ) // Load next page when dispalaying first item of current page.
    {
        self.currentPage++;
    }
}




@end

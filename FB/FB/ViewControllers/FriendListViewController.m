//
//  FriendListViewController.m
//  FB
//
//  Created by Nikita Rosenberg on 8/14/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import "FriendListViewController.h"




NSUInteger const itemsPerPage = 5; 




@implementation FriendListViewController


#pragma mark - Synthesize

@synthesize nextPageGraphPath =_nextPageGraphPath, previousPageGraphPath =_previousPageGraphPath;
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
    friends = [NSMutableArray new];
    currentPage = 0;
    [self loadPage:currentPage];
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




#pragma mark - Facebook




- (void) loadPage:(NSUInteger)page
{   
    [self.activityIndicator startAnimating];
    
    NSString *graphPath = [NSString stringWithFormat:@"me/friends?limit=%u&offset=%u", itemsPerPage, page*itemsPerPage];
    
    [FBRequestConnection startWithGraphPath:graphPath
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
             NSMutableArray *indexPaths = [NSMutableArray new];
             
             for ( NSUInteger i = 0; i < [[result valueForKey:@"data"] count]; i++ )
             {
                 NSDictionary *dict = [[result valueForKey:@"data"] objectAtIndex:i];
                 User *friend = [[User alloc] initWithDictionary:dict];
                 [friends addObject:friend];
                 [friend release];
                 [indexPaths addObject:[NSIndexPath indexPathForRow:currentPage*itemsPerPage+i inSection:0]];
             }
             
             [self.tableViewFriends insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
             
             //[self.tableViewFriends reloadData];
             [self.activityIndicator stopAnimating];
             
             self.title = [NSString stringWithFormat:@"Friends (%d)", [friends count]];
         }
         
         //[Common showAlertWithTitle:@"Result" andMessage:alertText];
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
    return 64.0f;
}
*/




- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self loadPage:++currentPage];
}




- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == currentPage*itemsPerPage + itemsPerPage-2 )
    {
        [self loadPage:++currentPage];
    }
}




@end

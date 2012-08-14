//
//  User.m
//  FB
//
//  Created by Nikita Rosenberg on 8/14/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import "User.h"




@implementation User


#pragma mark - Synthesize


@synthesize userId = _userId, name = _name;




#pragma mark - Object Lifecycle


- (User *) initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if ( self )
    {
        self.userId = [[dict valueForKey:@"id"] longLongValue];
        self.name = [dict valueForKey:@"name"];
    }
         
    return self;
}


@end

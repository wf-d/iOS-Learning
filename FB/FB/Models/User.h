//
//  User.h
//  FB
//
//  Created by Nikita Rosenberg on 8/14/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import <Foundation/Foundation.h>




@interface User : NSObject


@property (assign, nonatomic) long long userId;
@property (retain, nonatomic) NSString *name;


- (User *) initWithDictionary:(NSDictionary *)dict;


@end

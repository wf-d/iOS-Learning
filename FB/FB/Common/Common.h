//
//  Common.h
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//





#import <Foundation/Foundation.h>




@interface Common : NSObject
<UIAlertViewDelegate>


+ (void) showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;


@end

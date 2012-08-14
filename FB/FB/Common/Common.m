//
//  Common.m
//  FB
//
//  Created by Nikita Rosenberg on 8/13/12.
//  Copyright (c) 2012 Saritasa LLC. All rights reserved.
//




#import "Common.h"




@implementation Common


+ (void) showAlertWithTitle:(NSString *)title andMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];    
}




#pragma mark - UIAlertViewDelegate


+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [alertView release];
}




+ (AppDelegate *) appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}




+ (NSString *) stringFromLongLong:(long long)longLongValue;
{
    return [NSString stringWithFormat:@"%lld", longLongValue];
}




@end

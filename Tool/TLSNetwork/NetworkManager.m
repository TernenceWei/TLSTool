//
//  NetworkManager.m
//  Tool
//
//  Created by Ternence on 15/12/28.
//  Copyright © 2015年 Leomaster. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager
+ (instancetype)sharedInstance
{
    static dispatch_once_t token;
    static NetworkManager *sInstance = nil;
    dispatch_once(&token, ^{
        sInstance = [[self alloc] init];
    });
    return sInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end

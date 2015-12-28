//
//  TLSLocalNotificationManager.h
//  Tool
//
//  Created by Ternence on 15/12/28.
//  Copyright © 2015年 Leomaster. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    LNT_default,
    LNT_weakup,
    LNT_scanCodeSuccess,
    LNT_flowWarning,
    
}LocalNotificationType;

@interface TLSLocalNotificationManager : NSObject
+ (instancetype)sharedInstance;
- (void)registLocalNotification:(LocalNotificationType)type;
@end

//
//  TLSLocalNotificationManager.m
//  Tool
//
//  Created by Ternence on 15/12/28.
//  Copyright © 2015年 Leomaster. All rights reserved.
//

#import "TLSLocalNotificationManager.h"
#import <UIKit/UIKit.h>

static TLSLocalNotificationManager* sharedInstance;
@implementation TLSLocalNotificationManager
+ (instancetype)sharedInstance{
    if (sharedInstance == nil) {
        sharedInstance = [[TLSLocalNotificationManager alloc] init];
    }
    return sharedInstance;
}

- (NSString*)formatTypeToString:(LocalNotificationType)type {
    NSString *result = nil;
    
    switch(type) {
        case LNT_weakup:
            result = @"LNT_weakup";
            break;
        case LNT_scanCodeSuccess:
            result = @"LNT_scanCodeSuccess";
            break;
        case LNT_flowWarning:
            result = @"LNT_flowWarning";
            break;
        default:
            result = @"LNT_default";
    }
    
    return result;
}

- (void)registLocalNotification:(LocalNotificationType)type
{

    NSDate* today = [NSDate date];
    NSDate *fireDate = [today dateByAddingTimeInterval:24*3600];
    NSString *content = @"what's up";
    NSString *actionUrl = nil;
    NSCalendarUnit repeatInterval = NSCalendarUnitWeekOfYear;
    switch (type) {
        case LNT_weakup:{

            break;
        }
        case LNT_scanCodeSuccess:{

            [self cleanLocalNotificationWithType:type];
            fireDate = [today dateByAddingTimeInterval:24*3600];
            repeatInterval = 0;
            content = NSLocalizedString(@"Wanna quicker scan next time? Put the QR code shortcut on the homescreen!", nil);
            actionUrl = nil;
            break;
        }
        case LNT_flowWarning:{
            [self cleanLocalNotificationWithType:type];
            fireDate = [today dateByAddingTimeInterval:0.5];
            repeatInterval = 0;
            content = NSLocalizedString(@"Wanna quicker scan next time? Put the QR code shortcut on the homescreen!", nil);
            actionUrl = nil;
            break;
        }
        case LNT_default:{
            [self cleanLocalNotificationWithType:type];
            fireDate = [today dateByAddingTimeInterval:24*3600];
            repeatInterval = NSCalendarUnitWeekOfYear;
            content = NSLocalizedString(@"Got some prying eyes around you? Hide personal images & videos!", nil);
            actionUrl = nil;
            break;
        }
            
    }
    
    [self registLocalNotificationWithType:type
                                     Date:fireDate
                           RepeatInterval:repeatInterval
                                  Content:content
                                ActionURL:actionUrl];
    
}

- (void)cleanLocalNotificationWithType:(LocalNotificationType)Ltype{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString *type=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"type"]];
        if ([type isEqualToString:[self formatTypeToString:Ltype]])
        {
            [app cancelLocalNotification:oneEvent];
            break;
        }
    }
}

- (void)registLocalNotificationWithType:(LocalNotificationType)type
                                   Date:(NSDate*)date
                         RepeatInterval:(NSCalendarUnit)repeatInterval
                                Content:(NSString*)content
                              ActionURL:(NSString*)actionURL{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIUserNotificationSettings* currentSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        UIApplication *application = [UIApplication sharedApplication];
        
        if (currentSettings.types == UIUserNotificationTypeNone) {
            if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
                UIUserNotificationType types = UIUserNotificationTypeBadge |UIUserNotificationTypeSound |UIUserNotificationTypeAlert;
                UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
                [application registerUserNotificationSettings:mySettings];
                
                
            }
        }
    }
    
    long long timeNowstamp = [[NSDate date] timeIntervalSince1970];
    
    NSDictionary *userInfo = @{@"message":content,
                               @"uid":[NSString stringWithFormat:@"%lld",timeNowstamp],
                               @"type":[self formatTypeToString:type],
                               @"actionURL":actionURL
                               };
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = date;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.userInfo = userInfo;
    notification.alertBody = content;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    notification.repeatCalendar = calendar;
    notification.repeatInterval = repeatInterval;
    
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end

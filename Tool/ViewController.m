//
//  ViewController.m
//  Tool
//
//  Created by Ternence on 15/12/28.
//  Copyright © 2015年 Leomaster. All rights reserved.
//

#import "ViewController.h"
#import "TLSToolHeader.h"
#import "TLSPopUpMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btton.frame = CGRectMake(100, 100, 40, 40);
    [btton addTarget:self action:@selector(onadd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btton];
    
    
}

- (void)onadd:(UIButton *)BUTTON
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 30; i++) {
        TLSPopUpMenuObject *object = [[TLSPopUpMenuObject alloc] init];
        object.iconUrl = [NSString stringWithFormat:@"iconUrl%d",i];
        object.domain = [NSString stringWithFormat:@"domain%d",i];
        object.webUrl = [NSString stringWithFormat:@"webUrl%d",i];
        [array addObject:object];
    }
    TLSPopUpMenu* menu = [[TLSPopUpMenu alloc] initWithSize:CGSizeMake(217, 220) Array:array];
    [menu showMenuInView:BUTTON];
    [menu setSelectBlock:^(TLSPopUpMenuObject *webinfo) {
        NSLog(@"%@",webinfo);

    }];

}

@end

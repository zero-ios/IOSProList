//
// Created by ZEROwolf Hwang on 2019-05-30.
// Copyright (c) 2019 ZEROwolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OutDelegate.h"


//委托方创建一个协议
@protocol passValueDelegate <NSObject>

//协议定义一个传值的方法
- (void)passValue:(NSString *)string;

@end



@interface NextViewController : UIViewController

@property (nonatomic, strong) NSString *str;

//定义一个持有协议的id指针
@property (weak) id <passValueDelegate> passDelegate;
@property (weak) id <OutDelegate> outDelegate;

//定义一个block进行页面反向传值
@property (copy) void (^block)(NSString *);

@end

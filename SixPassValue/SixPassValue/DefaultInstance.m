//
// Created by ZEROwolf Hwang on 2019-05-30.
// Copyright (c) 2019 ZEROwolf. All rights reserved.
//

#import "DefaultInstance.h"


@implementation DefaultInstance

+ (instancetype)sharedInstance {
    static DefaultInstance *instance;

    if (!instance) {
        instance = [[DefaultInstance alloc] init];
    }

    return instance;
}


@end

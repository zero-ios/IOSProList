//
//  AppDelegate.m
//  SixPassValue
//
//  Created by ZEROwolf Hwang on 2019-05-30.
//  Copyright © 2019 ZEROwolf. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ViewController *mainVC = [[ViewController alloc] init];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];

    [nav setNavigationBarHidden:YES];

    [nav.view setBackgroundColor:[UIColor whiteColor]];

    self.window.rootViewController = nav;

    return YES;

}


@end

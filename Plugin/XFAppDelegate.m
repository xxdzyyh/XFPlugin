//
//  XFAppDelegate.m
//  FileShareTest
//
//  Created by wangxuefeng on 16/6/8.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFAppDelegate.h"

@implementation XFAppDelegate

- (NSArray *)plugins {
    return [[XFPluginManager defaultManager] getAllPlugins];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [obj application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

#pragma mark - 应用状态转变

- (void)applicationWillResignActive:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationWillResignActive:)]) {
            [obj applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [obj applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [obj applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [obj applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationWillTerminate:)]) {
            [obj applicationWillTerminate:application];
        }
    }
}

#pragma mark - 应用间交互

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL canOpen = NO;
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:handleOpenURL:)]) {
            canOpen = [obj application:application handleOpenURL:url];
        }
    }
    return canOpen;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL canOpen = NO;
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            canOpen = [obj application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    return canOpen;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    BOOL canOpen = NO;
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:openURL:options:)]) {
            canOpen = [obj application:application openURL:url options:options];
        }
    }
    return canOpen;
}

#pragma mark - 推送相关

#pragma mark - setter & getter 

- (UIWindow *)window {
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

- (XFPluginManager *)pluginManager {
    if (_pluginManager == nil) {
        _pluginManager = [XFPluginManager defaultManager];
    }
    return _pluginManager;
}

@end

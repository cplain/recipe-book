//
//  AppDelegate.h
//  RecipieBook
//
//  Created by Coby Plain on 31/05/13.
//  Copyright (c) 2013 Coby Plain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashScreenViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SplashScreenViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigController;

@end

//
//  AppDelegate.h
//  Hitachi
//
//  Created by Apple on 29/11/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeVC.h"
#import "SITSDashboardVC.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+(AppDelegate *)SharedDelegate;

@end


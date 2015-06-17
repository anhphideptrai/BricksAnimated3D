//
//  AppDelegate.h
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/27/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadManager.h"

typedef enum {
    SIMPLE_LEGO_TYPE,
    NORMAL_LEGO_TYPE
}LEGO_TYPE_SCREEN;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *moreApps;
@property (strong, nonatomic) ConfigApp *config;
@property (strong, nonatomic) DownloadManager *downloadManager;
@property (nonatomic) LEGO_TYPE_SCREEN legoType;

@end


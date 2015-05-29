//
//  Brick.h
//  HTMLParsing
//
//  Created by Phi Nguyen on 5/27/15.
//  Copyright (c) 2015 Swipe Stack Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lego : NSObject
@property (nonatomic, strong) NSString *iDLego;
@property (nonatomic, strong) NSString *iDGroup;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bricks;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *preview;
@property (nonatomic) NSUInteger totalBricks;
@property (nonatomic) NSUInteger size;
@property (nonatomic) BOOL isDownloaded;
@property (nonatomic, strong) NSMutableArray *legoSteps;
@end

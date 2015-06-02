//
//  MoreApp.h
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 6/2/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreApp : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *descriptionApp;
@property (nonatomic, strong) NSString *urlImage;
@property (nonatomic, strong) NSString *urlItunes;
+ (NSArray*)parser:(id)json;
@end

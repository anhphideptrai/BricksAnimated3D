//
//  LegoImage.h
//  HTMLParsing
//
//  Created by Phi Nguyen on 5/28/15.
//  Copyright (c) 2015 Swipe Stack Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LegoImage : NSObject
@property (nonatomic, strong) NSString *iDStep;
@property (nonatomic, strong) NSString *iDLego;
@property (nonatomic, strong) NSString *iDImage;
@property (nonatomic, strong) NSString *urlImage;
@property (nonatomic) NSUInteger size;
@end

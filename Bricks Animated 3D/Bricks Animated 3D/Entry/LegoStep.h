//
//  BrickStep.h
//  HTMLParsing
//
//  Created by Phi Nguyen on 5/27/15.
//  Copyright (c) 2015 Swipe Stack Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lego.h"

@interface LegoStep : Lego
@property (nonatomic, strong) NSString *iDStep;
@property (nonatomic, strong) NSMutableArray *legoImgs;
@property (nonatomic, strong) NSString *urlImage;
@end

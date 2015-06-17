//
//  BrickGroup.h
//  HTMLParsing
//
//  Created by Phi Nguyen on 5/27/15.
//  Copyright (c) 2015 Swipe Stack Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LegoGroup : NSObject
@property (nonatomic, strong) NSString *iDGroup;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *iDLegos;
@property (nonatomic, strong) NSMutableArray *legoes;
@end

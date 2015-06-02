//
//  MoreApp.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 6/2/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "MoreApp.h"

@implementation MoreApp
+ (NSArray*)parser:(id)json{
    if (json == nil) return nil;
    NSMutableArray *arr = [NSMutableArray new];
    if ([json isKindOfClass:[NSArray class]]) {
        for (id js in json) {
            MoreApp *moreApp = [MoreApp new];
            [moreApp setName:[js valueForKey:@"name"]];
            [moreApp setDescriptionApp:[js valueForKey:@"description"]];
            [moreApp setUrlImage:[js valueForKey:@"urlImage"]];
            [moreApp setUrlItunes:[js valueForKey:@"urlItunes"]];
            [arr addObject:moreApp];
        }
    }
    return [[NSArray alloc] initWithArray:arr];
}
@end

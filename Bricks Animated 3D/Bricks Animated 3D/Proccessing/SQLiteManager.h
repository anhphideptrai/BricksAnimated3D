//
//  SQLiteManager.h
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/29/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLiteManager : NSObject
+ (SQLiteManager*)getInstance;
- (NSMutableArray*)getAllLegoGroup;
- (NSMutableArray*)getLegoImagesWithIDLego:(NSString*)iDLego;
- (NSMutableArray*)getLegoStepsWithIDLego:(NSString*)iDLego;
- (BOOL)didDownloadedLego:(NSString*)iDLego;
@end

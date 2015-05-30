//
//  Utils.h
//  Pokedex Characters
//
//  Created by Phi Nguyen on 10/11/14.
//  Copyright (c) 2014 Duc Thien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
+ (NSString *)documentsPathForFileName:(NSString *)name;
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
//+ (NSString *) admobDeviceID;
@end

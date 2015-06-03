//
//  ConfigApp.h
//  Pokedex Characters
//
//  Created by Phi Nguyen on 10/14/14.
//  Copyright (c) 2014 Duc Thien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigApp : NSObject
@property(nonatomic, strong) NSString *statusApp;
@property(nonatomic, strong) NSString *adsShow;
@property(nonatomic, strong) NSString *moreShow;
@property(nonatomic, strong) NSString *urliTunes;
- (id)init;
- (void)parser:(id)json;
@end

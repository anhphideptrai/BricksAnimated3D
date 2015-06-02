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
@property(nonatomic, strong) NSString *urlShare;
@property(nonatomic, strong) NSString *urlServer;
@property(nonatomic, strong) NSString *version;
@property(nonatomic, strong) NSString *expriredDay;
@property(nonatomic, strong) NSString *urlApp1;
- (id)init;
- (void)parser:(id)json;
@end

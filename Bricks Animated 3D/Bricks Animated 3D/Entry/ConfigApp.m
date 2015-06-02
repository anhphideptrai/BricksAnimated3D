//
//  ConfigApp.m
//  Pokedex Characters
//
//  Created by Phi Nguyen on 10/14/14.
//  Copyright (c) 2014 Duc Thien. All rights reserved.
//

#import "ConfigApp.h"
#define key_status_app @"status.app"
#define key_url_share @"url.share"
#define key_version @"version"
#define key_expired_day @"expired.day"
#define key_url_server @"url.server"
#define key_url_app_1 @"url.app1"
@implementation ConfigApp
- (id)init{
    self = [super init];
    if (self) {
        self.statusApp = @"";
        self.urlShare = @"";
        self.urlServer = @"";
        self.version = @"";
        self.expriredDay = @"";
        self.urlApp1 = @"";
    }
    return self;
}
- (void)parser:(id)json{
    if (json == nil) return;
    self.statusApp = [json valueForKey:key_status_app];
    self.urlShare = [json valueForKey:key_url_share];
    self.urlServer = [json valueForKey:key_url_server];
    self.version = [json valueForKey:key_version];
    self.expriredDay = [json valueForKey:key_expired_day];
    self.urlApp1 = [json valueForKey:key_url_app_1];
    
}
@end

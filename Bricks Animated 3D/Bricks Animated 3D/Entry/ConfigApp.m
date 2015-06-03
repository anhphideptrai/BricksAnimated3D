//
//  ConfigApp.m
//  Pokedex Characters
//
//  Created by Phi Nguyen on 10/14/14.
//  Copyright (c) 2014 Duc Thien. All rights reserved.
//

#import "ConfigApp.h"
#define key_status_app @"status.app"
#define key_ads_show @"ads.show"
#define key_more_show @"more.show"
#define key_url_itunes @"url.itunes"
@implementation ConfigApp
- (id)init{
    self = [super init];
    if (self) {
        self.statusApp = @"";
        self.adsShow = @"";
        self.moreShow = @"";
        self.urliTunes = @"";
    }
    return self;
}
- (void)parser:(id)json{
    if (json == nil) return;
    self.statusApp = [json valueForKey:key_status_app];
    self.adsShow = [json valueForKey:key_ads_show];
    self.moreShow = [json valueForKey:key_more_show];
    self.urliTunes = [json valueForKey:key_url_itunes];
    
}
@end

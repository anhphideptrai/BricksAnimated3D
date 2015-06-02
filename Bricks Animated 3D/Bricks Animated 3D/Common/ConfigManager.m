//
//  ConfigManager.m
//  Pokedex Characters
//
//  Created by Phi Nguyen on 10/14/14.
//  Copyright (c) 2014 Duc Thien. All rights reserved.
//

#import "ConfigManager.h"

@implementation ConfigManager

static ConfigManager *thisInstance;

+ (ConfigManager *) getInstance{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        thisInstance = [[ConfigManager alloc] init];
        thisInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    }
    return thisInstance;
}

- (void)loadConfig:(NSString *)url
          finished:(void (^)(BOOL success, ConfigApp *configApp))finished{
    [self GET:url parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          ConfigApp *config = [[ConfigApp alloc] init];
          id json = [responseObject valueForKey:@"config"];
          [config parser:json];
          if (finished) {
              if (config) {
                  finished(YES, config);
              }else{
                  finished(NO, nil);
              }
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (finished) {
              finished(NO, nil);
          }
      }];
}
- (void)loadMoreApp:(NSString *)url
           finished:(void (^)(BOOL success, NSArray *moreApps))finished{
    [self GET:url parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          id json = [responseObject valueForKey:@"items"];
          NSArray *result = [MoreApp parser:json];
          if (finished) {
              if (result) {
                  finished(YES, result);
              }else{
                  finished(NO, nil);
              }
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (finished) {
              finished(NO, nil);
          }
      }];

}
@end

//
//  Utils.m
//  Pokedex Characters
//
//  Created by Phi Nguyen on 10/11/14.
//  Copyright (c) 2014 Duc Thien. All rights reserved.
//

#import "Utils.h"
//#import <AdSupport/ASIdentifierManager.h>
//#include <CommonCrypto/CommonDigest.h>

@implementation Utils
+ (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:name];
}
+ (NSString*)formatLessonID:(NSString*)lessonID{
    return lessonID.length < 2 ? [NSString stringWithFormat:@"0%@", lessonID] : lessonID;
}
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}
// + (NSString *) admobDeviceID
// {
// NSUUID* adid = [[ASIdentifierManager sharedManager] advertisingIdentifier];
// const char *cStr = [adid.UUIDString UTF8String];
// unsigned char digest[16];
// CC_MD5( cStr, strlen(cStr), digest );
// 
// NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
// 
// for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
// [output appendFormat:@"%02x", digest[i]];
// 
// return  output;
// 
// }
@end

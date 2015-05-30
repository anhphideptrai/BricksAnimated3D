//
//  DownloadManager.h
//  Pokedex Guide
//
//  Created by Phi Nguyen on 12/5/14.
//  Copyright (c) 2014 Duc Thien. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DownloadManagerDelegate <NSObject>
@optional
- (void)didFinishedDownloadFileWith:(NSURL*)filePath atIndex:(NSInteger)index withError:(NSError*)error;
- (void)didFinishedDownloadFilesWith:(NSArray *)filePaths withError:(NSError*)error;
- (void)completePercent:(NSInteger)percent;
@end
@interface DownloadEntry : NSObject
@property (nonatomic, strong) NSString* strUrl;
@property (nonatomic, strong) NSString* fileName;
@property (nonatomic, strong) NSString* dir;
@property (nonatomic) NSInteger size;
@end
@interface DownloadManager : NSObject
@property (nonatomic, assign) id<DownloadManagerDelegate> delegate;
- (void)dowloadFilesWith:(NSArray*)downloadEntries;
@end

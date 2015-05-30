//
//  DownloadManager.m
//  Pokedex Guide
//
//  Created by Phi Nguyen on 12/5/14.
//  Copyright (c) 2014 Duc Thien. All rights reserved.
//

#import "DownloadManager.h"
#import <AFNetworking.h>
#import "Utils.h"
#define FRACTION_COMPLETED @"fractionCompleted"
@interface DownloadManager(){
    NSArray *files;
    NSInteger totalSize;
    NSInteger downloadedSize;
    NSInteger currentIndex;
    NSArray *entries;
    NSError *_error;
}
@end
@implementation DownloadManager

- (void)dowloadFilesWith:(NSArray*)downloadEntries{
    _error = nil;
    totalSize = 0;
    downloadedSize = 0;
    currentIndex = 0;
    entries = downloadEntries;
    for (DownloadEntry *entry in downloadEntries) {
        totalSize += entry.size;
    }
    [self proccessingDownload];
}

-(void)proccessingDownload{
    DownloadEntry *entry = entries[currentIndex];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectoryURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *dirURL = [documentsDirectoryURL URLByAppendingPathComponent:entry.dir];
    if ([fileManager fileExistsAtPath:dirURL.path] == NO) {
        [fileManager createDirectoryAtPath:dirURL.path withIntermediateDirectories:NO attributes:nil error:nil];
        [Utils addSkipBackupAttributeToItemAtURL:dirURL];
    }
    NSURL *url = [NSURL URLWithString:entry.strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSProgress *progress;
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [dirURL URLByAppendingPathComponent:entry.fileName];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        downloadedSize += entry.size;
        if (error) {
            _error = error;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedDownloadFileWith:atIndex:withError:)]) {
            [self.delegate didFinishedDownloadFileWith:filePath atIndex:currentIndex withError:error];
        }
        if (++currentIndex < entries.count) {
            [self proccessingDownload];
        }else{
            if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishedDownloadFilesWith:withError:)]) {
                [self.delegate didFinishedDownloadFilesWith:nil withError:_error];
            }
        }
        [progress removeObserver:self forKeyPath:FRACTION_COMPLETED context:NULL];
    }];
    [downloadTask resume];
    [progress addObserver:self
               forKeyPath:FRACTION_COMPLETED
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:FRACTION_COMPLETED]) {
        NSProgress *progress = (NSProgress *)object;
        NSInteger currentSize = progress.fractionCompleted*((DownloadEntry*)entries[currentIndex]).size + downloadedSize;
        int percentCompledted = (int)((float)currentSize/(float)totalSize * 100);
        NSLog(@"Progress… %d", percentCompledted);
        if (self.delegate && [self.delegate respondsToSelector:@selector(completePercent:)]) {
            [self.delegate completePercent:percentCompledted];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
@implementation DownloadEntry
@end

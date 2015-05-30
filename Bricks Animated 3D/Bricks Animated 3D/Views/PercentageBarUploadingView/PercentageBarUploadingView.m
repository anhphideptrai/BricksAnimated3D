//
//  PercentageBarUploadingView.m
//  Orgit
//
//  Created by Phi Nguyen on 5/24/15.
//  Copyright (c) 2015 Orgit. All rights reserved.
//

#import "PercentageBarUploadingView.h"

@interface PercentageBarUploadingView (){
    NSUInteger currentPercent;
}
@property (weak, nonatomic) IBOutlet UILabel *lbPercent;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation PercentageBarUploadingView

- (void)viewDidLoad {
    [super viewDidLoad];
    [_lbPercent setTextColor:[UIColor whiteColor]];
    [_lbPercent setTextAlignment:NSTextAlignmentCenter];
    [_lbPercent setFont:_LABEL_PERCENT_FONT_];
    [_progressView setProgressTintColor:UIColorFromRGB(0x2a9c40)];
    [_progressView setTrackTintColor:[UIColor whiteColor]];
    [_progressView setProgress:0.f];
}
- (void)setPercent:(NSUInteger)percent{
    if (percent >= currentPercent) {
        currentPercent = percent;
        [_lbPercent setText:[NSString stringWithFormat:@"%ld %%", currentPercent]];
        [self.progressView setProgress:currentPercent/100.f];
    }
}
- (void)setTextLoading:(NSString*)txtLoading{
    [_lbPercent setText:txtLoading];
    currentPercent = 0;
}
@end

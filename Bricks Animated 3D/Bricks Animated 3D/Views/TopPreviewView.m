//
//  TopPreviewView.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/30/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "TopPreviewView.h"

@interface TopPreviewView(){
    Lego *_lego;
    UIImageView *imgV;
    UITextView *txtGuide;
    UIButton *btnAction;
}
@property (nonatomic, assign) id<TopPreviewViewDelegate> delegate;
@end
@implementation TopPreviewView

- (instancetype)initWithFrame:(CGRect)frame
                 withDelegate:(id<TopPreviewViewDelegate>)delegate
                      andLego:(Lego*)lego{
    self = [super initWithFrame:frame];
    if (self) {
        _lego = lego;
        _delegate = delegate;
        [self initCommon];
    }
    return self;
}
- (void)initCommon{
    imgV = [[UIImageView alloc] initWithFrame:CGRectMake(_PADDING_LEFT_RIGHT_, 0, self.frame.size.width - 2*_PADDING_LEFT_RIGHT_, self.frame.size.height - 2*_HEIGHT_BUTTON_AND_TEXT_)];
    btnAction = [[UIButton alloc] initWithFrame:CGRectMake(_PADDING_LEFT_RIGHT_, imgV.frame.size.height, imgV.frame.size.width, _HEIGHT_BUTTON_AND_TEXT_)];
    txtGuide = [[UITextView alloc] initWithFrame:CGRectMake(_PADDING_LEFT_RIGHT_, imgV.frame.size.height + _HEIGHT_BUTTON_AND_TEXT_, imgV.frame.size.width, _HEIGHT_BUTTON_AND_TEXT_)];
    
    [btnAction setBackgroundColor:UIColorFromRGB(0x2a9c40)];
    [btnAction.layer setCornerRadius:4.0f];
    [btnAction.layer setMasksToBounds:YES];
    [btnAction addTarget:self action:@selector(actionTapDownloadButton) forControlEvents:UIControlEventTouchUpInside];
    
    [txtGuide setUserInteractionEnabled:NO];
    [txtGuide setTextColor:[UIColor lightGrayColor]];
    [txtGuide setTextAlignment:NSTextAlignmentCenter];
    [txtGuide setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    
    [imgV setContentMode:UIViewContentModeScaleAspectFit];
    
    [imgV setImage:[UIImage imageNamed:_lego.preview]];
    [btnAction setTitle:@"Download now" forState:UIControlStateNormal];
    [txtGuide setText:@"You can use the same\nbricks of different color"];
    
    [self addSubview:imgV];
    [self addSubview:btnAction];
    [self addSubview:txtGuide];
}
- (void)actionTapDownloadButton{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickDownloadButton:)]) {
        [self.delegate didClickDownloadButton:self];
    }
}
@end

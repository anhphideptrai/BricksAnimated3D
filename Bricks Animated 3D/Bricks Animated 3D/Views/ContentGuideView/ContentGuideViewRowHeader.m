//
//  ContentGuideViewRowHeader.m
//  TelenorMyTV
//
//  Created by Phi Nguyen on 7/3/14.
//  Copyright (c) 2014 UUX. All rights reserved.
//

#import "ContentGuideViewRowHeader.h"

@interface ContentGuideViewRowHeader()
{
    CGFloat pandingLeft;
    UIFont *fontTitleRowHeader;
    UIImageView *backgroundView;

}
@property (nonatomic, retain) UILabel *lbTitleRowHeader;
@property (nonatomic, retain) UIImageView *iconHeader;

- (void)initCommon;
@end
@implementation ContentGuideViewRowHeader
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize style = _style;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithStyle:ContentGuideViewRowHeaderStyleDefault reuseIdentifier:@"ContentGuideViewRowHeaderStyleDefault"];
}
- (id)initWithStyle:(ContentGuideViewRowHeaderStyle)aStyle reuseIdentifier:(NSString *)aReuseIdentifier{
    if (self = [super initWithFrame:CGRectZero]) {
        self.opaque = YES;
        _reuseIdentifier = aReuseIdentifier;
        _style = aStyle;
        [self setBackgroundRowHeader:BACKGROUND_COLOR_ROWHEADER];
        self.lbTitleRowHeader = [[UILabel alloc] init];
        [self.lbTitleRowHeader setBackgroundColor:[UIColor clearColor]];
        fontTitleRowHeader = FONT_TITLE_ROW_HEADER_DEFAULT;
        [self addSubview:self.lbTitleRowHeader];
        pandingLeft = PANDING_LEFT_CONTENT_GUIDE_ROW_HEADER_DEFAULT;
        self.iconHeader = [[UIImageView alloc] init];
        [self.iconHeader setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.iconHeader];

    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self initCommon];
    
}

- (void) setBackground:(UIImage *)image{
    if (!backgroundView) {
        CGRect frameBG = self.frame;
        frameBG.origin.x = 0;
        frameBG.origin.y = 0;
        backgroundView = [[UIImageView alloc] initWithFrame:frameBG];
        [backgroundView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self insertSubview:backgroundView atIndex:0];
    }
    [backgroundView setImage:image];
}

- (void) setIconLeft: (UIImage *)image{
    if (image) {
        [self.iconHeader setImage:image];
    }
}

- (void)initCommon{
    [self setPandingLeftTitle:pandingLeft];
    [self setFontTitleRowHeader:fontTitleRowHeader];
    [self.lbTitleRowHeader setTextColor:[UIColor whiteColor]];
}
- (void) setTextTitleRowHeader:(NSString*) txtTitle{
    if (txtTitle) {
        [self.lbTitleRowHeader setText:txtTitle];
    }
}
- (void) setFontTitleRowHeader:(UIFont*) font{
    if (font) {
        [self.lbTitleRowHeader setFont:font];
    }
}
- (void) setBackgroundRowHeader:(UIColor *)backgroundColor{
    if (backgroundColor) {
        [self setBackgroundColor:backgroundColor];
    }
}
- (void) setPandingLeftTitle:(CGFloat) _pandingLeft{
    pandingLeft = _pandingLeft;
    CGRect frame = self.frame;
    frame.origin.x = pandingLeft;
    frame.origin.y = 2;
    frame.size.height -= 4;
    frame.size.width = frame.size.height;
    [self.iconHeader setFrame:frame];
    frame = self.frame;
    frame.origin.x = (self.iconHeader.frame.size.width + pandingLeft + 10);
    frame.size.width = self.frame.size.width - self.iconHeader.frame.origin.x;
    [self.lbTitleRowHeader setFrame:frame];

}
@end

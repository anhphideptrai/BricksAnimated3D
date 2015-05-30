//
//  ContentGuideViewRowCarouselViewPosterView.m
//  TelenorMyTV
//
//  Created by Phi Nguyen on 7/3/14.
//  Copyright (c) 2014 UUX. All rights reserved.
//

#import "ContentGuideViewRowCarouselViewPosterView.h"

#define POSTER_IMAGE_VIEW_FRAME CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - heightTitlePoster)
#define ICON_LEFT_FRAME   CGRectMake(0, POSTER_IMAGE_VIEW_FRAME.size.height - 30, self.frame.size.width/3, 30)
#define LABEL_RIGHT_FRAME CGRectMake(self.frame.size.width/3, POSTER_IMAGE_VIEW_FRAME.size.height - 30, self.frame.size.width * 2/3, 30)
#define LABEL_TITLE_FRAME CGRectMake(0, imageView.frame.size.height, self.frame.size.width, heightTitlePoster)
#define BUTTON_PLAY_FRAME CGRectMake(POSTER_IMAGE_VIEW_FRAME.size.width/2 - 16, POSTER_IMAGE_VIEW_FRAME.size.height/2 - 16, 32, 32)
#define BUTTON_CLICK_VIEW CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)

@interface ContentGuideViewRowCarouselViewPosterView()
{
    UIImageView *imageView;
    UIImageView *iconLeft;
    UILabel *lbRight;
    UILabel *lbTitle;
    CGFloat heightTitlePoster;
    UIFont *fontTitle;
    UIFont *fontRightLabel;
    UIImageView *btnPlay;
    UIButton *btnClickView;
    UIImageView *bgBottomLeft;
    UIImageView *bgBottomRight;
}
-(void)removeFromSuperview;
- (void) _initSubviews;
@end

@implementation ContentGuideViewRowCarouselViewPosterView
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize style = _style;
@synthesize index = _index;
@synthesize isNow = _isNow;
@synthesize isHighLight = _isHighLight;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithStyle:ContentGuideViewRowCarouselViewPosterViewStyleDefault reuseIdentifier:@"ContentGuideViewRowCarouselViewPosterViewStyleDefault"];
}
- (id)initWithStyle:(ContentGuideViewRowCarouselViewPosterViewStyle)aStyle reuseIdentifier:(NSString *)aReuseIdentifier{
    if (self = [super initWithFrame:CGRectZero]) {
        self.opaque = YES;
        _reuseIdentifier = aReuseIdentifier;
        _style = aStyle;
        [self _initSubviews];
    }
    return self;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setFrameForViews];
}

- (void) _initSubviews{

    _isNow = NO;
    
    imageView = [[UIImageView alloc] init];
    iconLeft = [[UIImageView alloc] init];
    btnPlay = [[UIImageView alloc] init];
    lbTitle = [[UILabel alloc] init];
    lbRight = [[UILabel alloc] init];
    btnClickView = [[UIButton alloc] init];
    bgBottomLeft = [[UIImageView alloc] init];
    bgBottomRight = [[UIImageView alloc] init];
    [imageView setBackgroundColor:[UIColor clearColor]];
    
    [bgBottomLeft setHidden:YES];
    [bgBottomRight setHidden:YES];
    
    heightTitlePoster = HEIGHT_TITLE_POSTER_DEFAULT;
    fontTitle = FONT_TITLE_POSTER_DEFAULT;
    fontRightLabel = FONT_RIGHT_LABEL_POSTER_DEFAULT;
    
    [lbTitle setBackgroundColor:[UIColor clearColor]];
    [lbTitle setTextColor:TEXT_COLOR_TITLE_POSTER_DEFAULT];
    [lbTitle setNumberOfLines:2];
    [lbTitle setTextAlignment:NSTextAlignmentCenter];
    [lbTitle setFont:fontTitle];
    
    [lbRight setBackgroundColor:[UIColor clearColor]];
    [lbRight setTextColor:TEXT_COLOR_RIGHT_LABEL_POSTER_DEFAULT];
    [lbRight setNumberOfLines:1];
    [lbRight setTextAlignment:NSTextAlignmentCenter];
    [lbRight setFont:fontRightLabel];
    
    [btnClickView setBackgroundColor:[UIColor clearColor]];
    [btnClickView addTarget:self action:@selector(actionClickView) forControlEvents:UIControlEventTouchUpInside];
    
    [btnPlay setBackgroundColor:[UIColor clearColor]];
    [iconLeft setContentMode:UIViewContentModeScaleAspectFit];
    [lbRight setContentMode:UIViewContentModeScaleToFill];
    
    [self addSubview:imageView];
    [self addSubview:btnPlay];
    [self addSubview:lbTitle];
    [self addSubview:bgBottomLeft];
    [self addSubview:bgBottomRight];
    [self addSubview:lbRight];
    [self addSubview:iconLeft];
    [self addSubview:btnClickView];
}
- (void) setFrameForViews{
    [imageView setFrame:POSTER_IMAGE_VIEW_FRAME];
    [lbTitle setFrame:LABEL_TITLE_FRAME];
    [btnClickView setFrame:BUTTON_CLICK_VIEW];
    [btnPlay setFrame:BUTTON_PLAY_FRAME];
    [bgBottomLeft setFrame:ICON_LEFT_FRAME];
    [bgBottomRight setFrame:LABEL_RIGHT_FRAME];
    [iconLeft setFrame:ICON_LEFT_FRAME];
    [lbRight setFrame:LABEL_RIGHT_FRAME];
}

- (void) loadData{
    if ([self.dataSource respondsToSelector:@selector(imageBackgroundBottomPosterView:)]) {
        UIImage *image = [self.dataSource imageBackgroundBottomPosterView:self];
        if (image) {
            [bgBottomLeft setImage:image];
            [bgBottomRight setImage:image];
        }
    }
}

- (void)setURLImagePoster:(NSString*)strURL placeholderImage:(UIImage *)placeholderImage{
    if (strURL && ![strURL isEqualToString:@""] && imageView) {
        NSURL *url = [NSURL URLWithString:strURL];
        if (placeholderImage) {
            [imageView setImageWithURL:url placeholderImage:placeholderImage];
        }else{
            [imageView setImageWithURL:url];
        }
    }
}
- (void)setHeightTitlePosterView:(CGFloat)height{
    if (height > 0) {
        heightTitlePoster = height;
        [self setFrameForViews];
    }
}
- (void) setTextTitlePoster:(NSString*) txtTitle{
    if (txtTitle) {
        [lbTitle setText:txtTitle];
    }
}
- (void) setFontTitlePoster:(UIFont*) font{
    if (font) {
        [lbTitle setFont:font];
    }
}

- (void) setTextRightLabel:(NSString*) txtRightLabel{
    [bgBottomRight setHidden:NO];
    if (txtRightLabel) {
        [lbRight setText:txtRightLabel];
    }
}

- (void) setFontRightLabel:(UIFont*) font{
    if (font) {
        [lbRight setFont:font];
    }
}

- (void) setURLImageIconLeft:(NSString*)strURL placeholderImage:(UIImage *)placeholderImage{
    [bgBottomLeft setHidden:NO];
    if (strURL && ![strURL isEqualToString:@""] && iconLeft) {
        NSURL *url = [NSURL URLWithString:strURL];
        if (placeholderImage) {
            [iconLeft setImageWithURL:url placeholderImage:placeholderImage];
        }else{
            [iconLeft setImageWithURL:url];
        }
    }
}
- (void) setIsNow{
    _isNow = YES;
}
- (void) resetHighLight{
    if (btnPlay) {
        [btnPlay setImage:nil];
        _isHighLight = NO;
    }
}

- (void) setImagePoster:(UIImage*) image{
    if (image) {
        [imageView setImage:image];
    }
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
    [imageView cancelImageRequestOperation];
    [iconLeft cancelImageRequestOperation];
    [imageView setImage:nil];
    [iconLeft setImage:nil];
    [btnPlay setImage:nil];
    [bgBottomLeft setImage:nil];
    [bgBottomLeft setHidden:YES];
    [bgBottomRight setImage:nil];
    [bgBottomRight setHidden:YES];
    [lbRight setText:@""];
    [lbTitle setText:@""];
    _isHighLight = NO;
    _isNow = NO;
}
- (void) actionClickView{
    if (_isNow && !_isHighLight && [self.delegate respondsToSelector:@selector(hightLightedPosterView:)]) {
        _isHighLight = YES;
        [self.delegate hightLightedPosterView:self];
        if ([self.dataSource respondsToSelector:@selector(imagePlayButtonForPosterView:)]) {
            UIImage *image = [self.dataSource imagePlayButtonForPosterView:self];
            if (image) {
                [btnPlay setImage:image];
            }
        }
    }else if ([self.delegate respondsToSelector:@selector(didSelectPosterView:)]) {
        [self.delegate didSelectPosterView:self];
    }
}
@end

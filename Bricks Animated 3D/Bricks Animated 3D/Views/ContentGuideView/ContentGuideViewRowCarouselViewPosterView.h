//
//  ContentGuideViewRowCarouselViewPosterView.h
//  TelenorMyTV
//
//  Created by Phi Nguyen on 7/3/14.
//  Copyright (c) 2014 UUX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
@class ContentGuideViewRowCarouselViewPosterView;

typedef enum {
    ContentGuideViewRowCarouselViewPosterViewStyleDefault
} ContentGuideViewRowCarouselViewPosterViewStyle;

@protocol ContentGuideViewRowCarouselViewPosterViewDataSource <NSObject>
@optional
- (UIImage*) imagePlayButtonForPosterView:(ContentGuideViewRowCarouselViewPosterView*) posterView;
- (UIImage*) imageBackgroundBottomPosterView:(ContentGuideViewRowCarouselViewPosterView*) posterView;
@end

@protocol ContentGuideViewRowCarouselViewPosterViewDelegate <NSObject>
@optional
- (void) didSelectPosterView:(ContentGuideViewRowCarouselViewPosterView*) posterView;
- (void) hightLightedPosterView:(ContentGuideViewRowCarouselViewPosterView*) posterView;
@end

@interface ContentGuideViewRowCarouselViewPosterView : UIView

@property (nonatomic, assign) IBOutlet id <ContentGuideViewRowCarouselViewPosterViewDelegate> delegate;
@property (nonatomic, assign) IBOutlet id <ContentGuideViewRowCarouselViewPosterViewDataSource> dataSource;
@property(nonatomic,readonly,copy) NSString *reuseIdentifier;
@property (nonatomic, readonly) NSInteger style;
@property (nonatomic, readwrite) NSInteger index;
@property (nonatomic, readonly) BOOL isNow;
@property (nonatomic, readonly) BOOL isHighLight;

- (id) initWithStyle:(ContentGuideViewRowCarouselViewPosterViewStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) setFrame:(CGRect)frame;
- (void) setStringURLImagePoster:(NSString*)strURL placeholderImage:(UIImage *)placeholderImage;
- (void) setURLImagePoster:(NSURL*)uRL placeholderImage:(UIImage *)placeholderImage;
- (void) setHeightTitlePosterView:(CGFloat)height;
- (void) setTextTitlePoster:(NSString*) txtTitle;
- (void) setFontTitlePoster:(UIFont*) font;
- (void) setTextRightLabel:(NSString*) txtRightLabel;
- (void) setFontRightLabel:(UIFont*) font;
- (void) setURLImageIconLeft:(NSString*)strURL placeholderImage:(UIImage *)placeholderImage;
- (void) setIsNow;
- (void) resetHighLight;
- (void) loadData;
- (void) setImagePoster:(UIImage*) image;
@end

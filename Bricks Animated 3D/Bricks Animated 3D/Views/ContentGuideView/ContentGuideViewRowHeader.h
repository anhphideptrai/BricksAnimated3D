//
//  ContentGuideViewRowHeader.h
//  TelenorMyTV
//
//  Created by Phi Nguyen on 7/3/14.
//  Copyright (c) 2014 UUX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ContentGuideViewRowHeaderStyleDefault,
} ContentGuideViewRowHeaderStyle;
@interface ContentGuideViewRowHeader : UIView{
    
}
@property(nonatomic,readonly,copy) NSString *reuseIdentifier;
@property (nonatomic, readonly) NSInteger style;
- (id)initWithStyle:(ContentGuideViewRowHeaderStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setFrame:(CGRect)frame;
- (void) setTextTitleRowHeader:(NSString*) txtTitle;
- (void) setFontTitleRowHeader:(UIFont*) font;
- (void) setBackgroundRowHeader:(UIColor *)backgroundColor;
- (void) setPandingLeftTitle:(CGFloat) pandingLeft;
- (void) setBackground:(UIImage *)image;
- (void) setIconLeft: (UIImage *)image;
@end

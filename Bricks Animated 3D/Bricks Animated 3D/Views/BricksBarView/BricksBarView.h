//
//  BottomToolBarView.h
//  Orgit
//
//  Created by Phi Nguyen on 10/29/14.
//  Copyright (c) 2014 Orgit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BricksBarView;
@protocol BricksBarViewDelegate<NSObject>
- (NSMutableArray*)dataItemsForBricksBarView:(BricksBarView*)bricksBarView;
@optional
- (void) didTapBottomToolBarItem:(BricksBarView*)bricksBarView;
@end
@interface BricksBarView : UIView
@property (nonatomic, assign) IBOutlet id  <BricksBarViewDelegate> delegate;
- (instancetype)initBricksBarWithFrame:(CGRect)frame;
- (void)setImageBackgroud:(UIImage*)imageBG;
- (void)setBackgroundColorForView:(UIColor*)bGColor;
- (void)setBackgroundAlpha:(CGFloat)alpha;
- (void)loadView;
- (void)clearView;
@end

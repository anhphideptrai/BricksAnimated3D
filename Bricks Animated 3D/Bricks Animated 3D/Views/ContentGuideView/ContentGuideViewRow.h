//
//  ContentGuideViewRow.h
//  TelenorMyTV
//
//  Created by Phi Nguyen on 7/3/14.
//  Copyright (c) 2014 UUX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentGuideViewRow;
@class ContentGuideViewRowCarouselViewPosterView;
@class ContentGuideViewRowHeader;
typedef enum {
    CarouselViewScrollDirectionLeftToRight = 0,
    CarouselViewScrollDirectionRightToLeft = 1
} CarouselViewScrollDirection;
typedef enum {
    ContentGuideViewRowStyleDefault,
} ContentGuideViewRowStyle;
@protocol ContentGuideViewRowDataSource <NSObject>
@required

- (NSUInteger) numberOfPostersInCarousel:(ContentGuideViewRow*) viewRow;

- (ContentGuideViewRowHeader*) headerForRow:(ContentGuideViewRow*) viewRow;

- (ContentGuideViewRowCarouselViewPosterView*)contentGuide:(ContentGuideViewRow*) viewRow
                                          posterViewIndex:(NSUInteger)index;

- (CGRect)framePosterView:(ContentGuideViewRow*) viewRow
          posterViewIndex:(NSUInteger)index;

- (NSUInteger)beginVisiblePosterIndex:(ContentGuideViewRow*) viewRow;

@optional

- (UIImage*) imagePlayButtonForPosterView:(ContentGuideViewRow*) viewRow;

- (UIImage*) imageBackgroundBottomPosterView:(ContentGuideViewRow*) viewRow;

- (BOOL) showWating:(ContentGuideViewRow*) viewRow;

@end

@protocol ContentGuideViewRowDelegate <NSObject>
@required

- (CGFloat)heightForContentGuideViewRowHeader:(ContentGuideViewRow*) viewRow;

- (CGFloat)widthForContentGuideViewRowCarouselViewPosterView:(ContentGuideViewRow*) viewRow;

- (CGFloat)spaceBetweenCarouselViewPosterViews:(ContentGuideViewRow*) viewRow;

- (CGFloat)pandingTopAndBottomOfRowHeader:(ContentGuideViewRow*) viewRow;

@optional

- (void)         contentGuideViewRow:(ContentGuideViewRow*) viewRow
          didSelectPosterViewAtIndex:(NSUInteger) posterIndex;

- (void)      contentGuideViewRow:(ContentGuideViewRow*) viewRow
    didScrollToVisibleposterIndex:(NSUInteger) posterIndex
                    withDirection:(CarouselViewScrollDirection) direction;

- (void) headerViewRemoved:(ContentGuideViewRowHeader*)headerView
   fromContentGuideViewRow:(ContentGuideViewRow*)viewRow;

- (void)posterViewRemoved:(ContentGuideViewRowCarouselViewPosterView*)posterView
  fromContentGuideViewRow:(ContentGuideViewRow*)viewRow;
- (void) headerViewAdded:(ContentGuideViewRowHeader*)headerView
 fromContentGuideViewRow:(ContentGuideViewRow*)viewRow;

- (void)posterViewAdded:(ContentGuideViewRowCarouselViewPosterView*)posterView
fromContentGuideViewRow:(ContentGuideViewRow*)viewRow;

- (void) didChangedBeginVisiblePosterIndex:(ContentGuideViewRow*) viewRow
                                   toIndex:(NSUInteger)index;

@end

@interface ContentGuideViewRow : UIView{
@private
    UIImageView *backgroundView;
}
/** The object that acts as the data source of the receiving table view.
 */
@property (nonatomic, assign) IBOutlet id  <ContentGuideViewRowDataSource> dataSource;

/** The object that acts as the delegate of the receiving table view.
 */
@property (nonatomic, assign) IBOutlet id <ContentGuideViewRowDelegate> delegate;
@property (nonatomic, assign) NSUInteger rowIndex;
@property (nonatomic,readonly,copy) NSString *reuseIdentifier;
@property (nonatomic, readonly) NSInteger style;
@property (nonatomic, readonly) NSMutableArray *visiblePosters;
- (void) prepareForReuse;
- (id) initWithStyle:(ContentGuideViewRowStyle)style
     reuseIdentifier:(NSString *)reuseIdentifier;
- (void) setFrame:(CGRect)frame;
- (void) setBackgroundView:(UIView *)aBackgroundView;
- (void) reloadData;
- (void) showWaiting;
@end

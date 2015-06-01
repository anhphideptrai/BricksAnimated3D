//
//  BottomToolBarView.m
//  Orgit
//
//  Created by Phi Nguyen on 10/29/14.
//  Copyright (c) 2014 Orgit. All rights reserved.
//

#import "BricksBarView.h"
#define _HEIGHT_WIDTH_ITEM_ 45
#define _HEIGHT_WIDTH_NUMBER_ITEM_ 15
#define _MAX_ITEMS_ 5

@interface BricksBarView(){
    UIImageView *bGImageView;
    NSMutableArray *dataItems;
    NSMutableArray *items;
}
@end
@implementation BricksBarView
- (instancetype)initBricksBarWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
    }
    return self;
}
- (void)initCommon{
    bGImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    dataItems = [[NSMutableArray alloc] init];
    items = [[NSMutableArray alloc] init];
    [self addSubview:bGImageView];
    [bGImageView setFrame:SET_X_Y_FRAME(0,0,self.frame)];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClickView)];
    [self addGestureRecognizer:singleTap];
}
- (void)setImageBackgroud:(UIImage*)imageBG{
    if (imageBG) {
        [bGImageView setImage:imageBG];
    }
}
- (void)setBackgroundColorForView:(UIColor*)bGColor{
    if (bGColor) {
        [bGImageView setBackgroundColor:bGColor];
    }
}
- (void)setBackgroundAlpha:(CGFloat)alpha{
    [bGImageView setAlpha:alpha];
}
- (void)loadView{
    [self clearView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dataItemsForBricksBarView:)]) {
        dataItems = [self.delegate dataItemsForBricksBarView:self];
    }
    NSUInteger numberItem = MIN(dataItems.count, _MAX_ITEMS_);
    int i = 0;
    for (LegoBrick *brick in dataItems) {
        if (i < _MAX_ITEMS_) {
            CGFloat _width_space_item_ = self.frame.size.width/numberItem;
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((_width_space_item_ - _HEIGHT_WIDTH_ITEM_)/2 + i*_width_space_item_, (self.frame.size.height - _HEIGHT_WIDTH_ITEM_)/2, _HEIGHT_WIDTH_ITEM_, _HEIGHT_WIDTH_ITEM_)];
            [imgView setContentMode:UIViewContentModeScaleAspectFit];
            [imgView setImageWithURL:[[NSBundle mainBundle] URLForResource:brick.name withExtension:@"png"]];
            
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.origin.x, imgView.frame.origin.y, _HEIGHT_WIDTH_NUMBER_ITEM_, _HEIGHT_WIDTH_NUMBER_ITEM_)];
            [lb setFont:[UIFont fontWithName:@"Helvetica" size:12.f]];
            [lb setTextColor:[UIColor blackColor]];
            [lb setText:[NSString stringWithFormat:@"%@x", brick.count]];
            
            [items addObject:imgView];
            [items addObject:lb];
            [self addSubview:imgView];
            [self addSubview:lb];
        }
        i++;
    }
}
- (void)clearView{
    [items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [items removeAllObjects];
    [dataItems removeAllObjects];
}
- (void)actionClickView{
    if (self.delegate && [self.delegate  respondsToSelector:@selector(didTapBottomToolBarItem:)]) {
        [self.delegate didTapBottomToolBarItem:self];
    }
}
@end

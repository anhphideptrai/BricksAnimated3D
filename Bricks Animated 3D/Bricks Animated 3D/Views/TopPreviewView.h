//
//  TopPreviewView.h
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/30/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lego.h"

@protocol TopPreviewViewDelegate <NSObject>
@end
@interface TopPreviewView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                 withDelegate:(id<TopPreviewViewDelegate>)delegate
               andLego:(Lego*)lego;
@end

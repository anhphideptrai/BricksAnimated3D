//
//  PreviewLegoViewController.h
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/29/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PreviewLegoViewController;
@protocol PreviewLegoViewControllerDelegate <NSObject>
- (void)didTapDownloadLego:(PreviewLegoViewController*)previewLegoVC;
@end
@interface PreviewLegoViewController : UIViewController
@property (nonatomic, assign) id<PreviewLegoViewControllerDelegate> delegate;
@property (nonatomic, strong) Lego *lego;
@end

//
//  ViewController.h
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/27/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    SIMPLE_LEGO_TYPE,
    NORMAL_LEGO_TYPE
}LEGO_TYPE_SCREEN;
@interface MainViewController : UIViewController
@property (nonatomic) LEGO_TYPE_SCREEN legoType;
@end


//
//  Constants.h
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/29/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#ifndef Bricks_Animated_3D_Constants_h
#define Bricks_Animated_3D_Constants_h

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_RETINA ([[UIScreen mainScreen] scale] == 2.0)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAndAlpha(rgbValue,_alpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:_alpha]

#define _NAME_DB_STRING_ @"TEVHT19EQi5zcWxpdGU="
#define _msg_rating_ @"Help make Bricks Animated 3D even better. Rate us 5 stars!"
#define _msg_rate_it_5_starts_ @"Rate it 5 stars"
#define _msg_dismiss_ @"Dismiss"

#define _url_share_ @"https://itunes.apple.com/app/id948768878"

#endif

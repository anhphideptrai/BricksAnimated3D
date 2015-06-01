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

#define HEIGHT_CONTENT_GUIDE_VIEW_ROW (IS_IPAD?245:165)
#define HEIGHT_CONTENT_GUIDE_VIEW_ROW_HEADER 30
#define WIDTH_POSTER_VIEW (IS_IPAD?167:87)
#define SPACE_BETWEEN_POSTER_VIEWS 20
#define PANDING_TOP_AND_BOTTOM_OF_ROW_HEADER (IS_IPAD?0:0)
#define NUMBER_POSTERS_IN_A_ROW (IS_IPAD?7:4)

/*
 ** START - CONSTANT OF CONTENT GUIDE VIEWS
 */
#define BACKGROUND_COLOR_ROWHEADER [UIColor colorWithRed:37.0f/255.0f green:64.0f/255.0f blue:68.0f/255.0f alpha:1.0f]
#define BACKGROUND_COLOR_CONTENTGUIDEVIEW [UIColor colorWithRed:25.0f/255.0f green:38.0f/255.0f blue:44.0f/255.0f alpha:1.0f]
#define PANDING_LEFT_CONTENT_GUIDE_ROW_HEADER_DEFAULT 10
#define HEIGHT_TITLE_POSTER_DEFAULT 50
#define TEXT_COLOR_TITLE_POSTER_DEFAULT [UIColor colorWithRed:.0f/255.0f green:.0f/255.0f blue:.0f/255.0f alpha:1.0f]
#define TEXT_COLOR_RIGHT_LABEL_POSTER_DEFAULT [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f]
#define FONT_TITLE_POSTER_DEFAULT [UIFont fontWithName:@"Helvetica" size:18.0f]
#define FONT_RIGHT_LABEL_POSTER_DEFAULT [UIFont fontWithName:@"Helvetica" size:(IS_IPAD?14.0f:12.0f)]
#define FONT_TITLE_ROW_HEADER_DEFAULT [UIFont fontWithName:@"Helvetica" size:20.0f]
#define TIME_AUTO_SCROLLING_PROMOSLIDES_DEFAULT 8
/*
 ** END - CONSTANT OF CONTENT GUIDE VIEWS
 */
/*
 ** START - FRAME CUSTOM
 */
#define SET_X_Y_FRAME(_x_, _y_, frameUpdate)   CGRectMake(_x_, _y_, frameUpdate.size.width, frameUpdate.size.height)
#define SET_X_FRAME(_x_, frameUpdate)     CGRectMake(_x_, frameUpdate.origin.y, frameUpdate.size.width, frameUpdate.size.height)
#define SET_Y_FRAME(_y_, frameUpdate)     CGRectMake(frameUpdate.origin.x, _y_, frameUpdate.size.width, frameUpdate.size.height)
#define SET_WIDTH_HEIGHT_FRAME(_width_, _height_, frameUpdate)     CGRectMake(frameUpdate.origin.x, frameUpdate.origin.y, _width_, _height_)
#define SET_WIDTH_FRAME(_width_, frameUpdate)     CGRectMake(frameUpdate.origin.x, frameUpdate.origin.y, _width_, frameUpdate.size.height)
#define SET_HEIGHT_FRAME(_height_, frameUpdate)     CGRectMake(frameUpdate.origin.x, frameUpdate.origin.y, frameUpdate.size.width, _height_)
/*
 ** END - FRAME CUSTOM
 */

#define _PADDING_LEFT_RIGHT_ 10
#define _HEIGHT_BUTTON_AND_TEXT_ 44

#define _LABEL_PERCENT_FONT_ [UIFont fontWithName:@"Helvetica" size:14.0f]

#endif

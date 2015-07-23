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
#define _NAME_DB_SIMPLE_STRING_ @"U0lNUExFX0xFR09fREIuc3FsaXRl="
#define _msg_rating_ @"Help make Animated Bricks 3D even better. Rate us 5 stars!"
#define _msg_rate_it_5_starts_ @"Rate it 5 stars"
#define _msg_dismiss_ @"Dismiss"

#define _msg_share_on_facebook_ @"Make a post on Facebook"
#define _msg_send_mail_to_friends @"Send mail to friends"
#define _msg_cancel_ @"Cancel"
#define _msg_share_ @"Share via"

#define _url_share_ @"https://itunes.apple.com/app/id1001195289"
#define _url_more_apps_ @"https://raw.githubusercontent.com/anhphideptrai/more-apps/master/more_apps_bricks_3d.json"

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

#define _TIME_TICK_CHANGE_ 3.f

#define _PADDING_LEFT_RIGHT_ 10
#define _HEIGHT_BUTTON_AND_TEXT_ 44

#define _LABEL_PERCENT_FONT_ [UIFont fontWithName:@"Helvetica" size:14.0f]

#define BANNER_ID_ADMOB_DETAIL_PAGE @"ca-app-pub-1775449000819183/5229441150"
#define INTERSTITIAL_ID_ADMOB_PAGE @"ca-app-pub-1775449000819183/3417643956"

#define CONFIG_STATUS_TAG @"CONFIG_STATUS_TAG"
#define CONFIG_ADS_TAG @"CONFIG_ADS_TAG"
#define CONFIG_MORE_TAG @"CONFIG_MORE_TAG"
#define CONFIG_URL_ITUNES_TAG @"CONFIG_URL_ITUNES_TAG"

#define SHOW_RATING_VIEW_TAG @"SHOW_RATING_VIEW_1"

#define _status_defalt_ @"beta2"
#define _ads_default_ @"beta"
#define _more_default_ @"beta2"

#endif

//
//  PreviewLegoViewController.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/29/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "PreviewLegoViewController.h"
#import "TopPreviewView.h"
#import "ContentGuideView.h"

@interface PreviewLegoViewController ()<ContentGuideViewDataSource, ContentGuideViewDelegate, TopPreviewViewDelegate>
@property (nonatomic, strong) ContentGuideView *contentGuideView;
@end

@implementation PreviewLegoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_lego) {
        [self.navigationItem setTitle:_lego.name];
    }
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x2a9c40);
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:nil];
    [leftButton setTitleTextAttributes:@{
                                          NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                          NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                          } forState:UIControlStateNormal];
    
    UIBarButtonItem *righttButton = [[UIBarButtonItem alloc] initWithTitle:@"Share!"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:nil];
    [righttButton setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                         NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                         } forState:UIControlStateNormal];
    
    [self.navigationItem setBackBarButtonItem:leftButton];
    [self.navigationItem setRightBarButtonItem:righttButton];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _contentGuideView = [[ContentGuideView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height)];
    [_contentGuideView setDataSource:self];
    [_contentGuideView setDelegate:self];
    [_contentGuideView reloadData];
    [self.view addSubview:_contentGuideView];
}
#pragma mark - ContentGuideViewDataSource methods
- (NSUInteger) numberOfPostersInCarousel:(ContentGuideView*) contentGuide atRowIndex:(NSUInteger) rowIndex{
    NSUInteger _numberOfRows = (_lego.bricks.count - 1)/NUMBER_POSTERS_IN_A_ROW + 1;
    NSUInteger _numberOfItems = _lego.bricks.count;
    if ((rowIndex == _numberOfRows -1) && _numberOfItems % NUMBER_POSTERS_IN_A_ROW > 0) {
        return _numberOfItems % NUMBER_POSTERS_IN_A_ROW;
    }
    return NUMBER_POSTERS_IN_A_ROW;
}
- (NSUInteger) numberOfRowsInContentGuide:(ContentGuideView*) contentGuide{
    NSUInteger numberPokemons = _lego.bricks.count;
    return numberPokemons == 0 ? 0 : (numberPokemons - 1)/NUMBER_POSTERS_IN_A_ROW + 1;
}
- (ContentGuideViewRow*) contentGuide:(ContentGuideView*) contentGuide
                       rowForRowIndex:(NSUInteger)rowIndex{
    static NSString *identifier = @"ContentGuideViewRowStyleDefault";
    ContentGuideViewRow *row = [contentGuide dequeueReusableRowWithIdentifier:identifier];
    if (!row) {
        row = [[ContentGuideViewRow alloc] initWithStyle:ContentGuideViewRowStyleDefault reuseIdentifier:identifier];
    }
    return row;
}
- (ContentGuideViewRowCarouselViewPosterView*)contentGuide:(ContentGuideView*) contentGuide
                                     posterViewForRowIndex:(NSUInteger)rowIndex
                                           posterViewIndex:(NSUInteger)index{
    static NSString *identifier = @"ContentGuideViewRowCarouselViewPosterViewStyleDefault";
    ContentGuideViewRowCarouselViewPosterView *posterView = [contentGuide dequeueReusablePosterViewWithIdentifier:identifier];
    if (!posterView) {
        posterView = [[ContentGuideViewRowCarouselViewPosterView alloc] initWithStyle:ContentGuideViewRowCarouselViewPosterViewStyleDefault reuseIdentifier:identifier];
    }
    LegoBrick *pokemon = (LegoBrick*)_lego.bricks[rowIndex*NUMBER_POSTERS_IN_A_ROW + index];
    [posterView setURLImagePoster:[[NSBundle mainBundle] URLForResource:pokemon.name withExtension:@"png"] placeholderImage:[UIImage imageNamed:@"icon_placeholder.png"]];
    [posterView setTextTitlePoster:[NSString stringWithFormat:@"%@x", pokemon.count]];
    return posterView;
    
}
- (UIView *)topCustomViewForContentGuideView:(ContentGuideView *)contentGuide{
    TopPreviewView *topPreviewV = [[TopPreviewView alloc] initWithFrame:SET_HEIGHT_FRAME(contentGuide.frame.size.width + 88, contentGuide.frame) withDelegate:nil andLego:_lego];
    return topPreviewV;
}
#pragma mark - ContentGuideViewDelegate methods
-(CGFloat)offsetYOfFirstRow:(ContentGuideView *)contentGuide{
    return contentGuide.frame.size.width + 88;
}
- (CGFloat)heightForContentGuideViewRow:(ContentGuideView*) contentGuide atRowIndex:(NSUInteger) rowIndex{
    return (contentGuide.frame.size.width/NUMBER_POSTERS_IN_A_ROW - SPACE_BETWEEN_POSTER_VIEWS + HEIGHT_TITLE_POSTER_DEFAULT);
}

- (CGFloat)heightForContentGuideViewRowHeader:(ContentGuideView*) contentGuide atRowIndex:(NSUInteger) rowIndex{
    return 0;
}

- (CGFloat)widthForContentGuideViewRowCarouselViewPosterView:(ContentGuideView*) contentGuide atRowIndex:(NSUInteger) rowIndex{
    return (contentGuide.frame.size.width/NUMBER_POSTERS_IN_A_ROW - SPACE_BETWEEN_POSTER_VIEWS);
}
- (CGFloat)spaceBetweenCarouselViewPosterViews:(ContentGuideView*) contentGuide  atRowIndex:(NSUInteger) rowIndex{
    return SPACE_BETWEEN_POSTER_VIEWS;
}

- (CGFloat)pandingTopAndBottomOfRowHeader:(ContentGuideView*) contentGuide  atRowIndex:(NSUInteger) rowIndex{
    return PANDING_TOP_AND_BOTTOM_OF_ROW_HEADER;
}
@end

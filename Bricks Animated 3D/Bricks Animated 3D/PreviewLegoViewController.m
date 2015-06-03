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
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import "AppDelegate.h"

@interface PreviewLegoViewController ()<ContentGuideViewDataSource, ContentGuideViewDelegate, TopPreviewViewDelegate, MFMailComposeViewControllerDelegate>{
    AppDelegate *appDelegate;
}
@property (nonatomic, strong) ContentGuideView *contentGuideView;
@end

@implementation PreviewLegoViewController

- (void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    appDelegate = [UIApplication sharedApplication].delegate;
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
                                                                  action:@selector(actionShare)];
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
- (void)actionShare{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_msg_share_ message:nil delegate:self cancelButtonTitle:_msg_cancel_ otherButtonTitles:_msg_share_on_facebook_, _msg_send_mail_to_friends, nil];
    [alert show];
}
- (void)viewWillAppear:(BOOL)animated{
    if (!_contentGuideView) {
        _contentGuideView = [[ContentGuideView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height)];
        [_contentGuideView setDataSource:self];
        [_contentGuideView setDelegate:self];
        [_contentGuideView reloadData];
        [self.view addSubview:_contentGuideView];
    }
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
    TopPreviewView *topPreviewV = [[TopPreviewView alloc] initWithFrame:SET_HEIGHT_FRAME(IS_IPAD?600:(contentGuide.frame.size.width - 2*_PADDING_LEFT_RIGHT_) + 88, contentGuide.frame) withDelegate:self andLego:_lego];
    return topPreviewV;
}
#pragma mark - ContentGuideViewDelegate methods
-(CGFloat)offsetYOfFirstRow:(ContentGuideView *)contentGuide{
    return IS_IPAD?600:(contentGuide.frame.size.width - 2*_PADDING_LEFT_RIGHT_) + 88 ;
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
#pragma mark - TopPreviewViewDelegate methods
- (void)didClickDownloadButton:(id)topPreviewView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapDownloadLego:)]) {
        [self.delegate didTapDownloadLego:self];
    }
}
#pragma mark - MFMailComposeViewControllerDelegate methods
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        if (buttonIndex == 1) {
            [self shareToFacebook];
        }else{
            [self sendMailInviteTo:@"" withSubject:@"Animated Bricks 3D for LEGO new creations" andContent:[NSString stringWithFormat:@"Lots of new instructions for Lego\niTunes:\n%@\n\nI like it!!!", appDelegate.config.urliTunes]];
        }
    }
}
// Invate utils
- (void)sendMailInviteTo:(NSString*)mail
             withSubject:(NSString*)subject
              andContent:(NSString*)contentMail{
    NSArray *toRecipents = [NSArray arrayWithObject:mail];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail] && mc) {
        mc.mailComposeDelegate = self;
        [mc setSubject:subject];
        [mc setMessageBody:contentMail isHTML:NO];
        [mc setToRecipients:toRecipents];
        NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:_lego.preview]);
        [mc addAttachmentData:imageData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"preview.png"]];
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
}
- (void)shareToFacebook{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [controller setInitialText:[NSString stringWithFormat:@"Lots of new instructions for Lego\niTunes:\n%@\n\nI like it!!!", appDelegate.config.urliTunes]];
    [controller addURL:[NSURL URLWithString:appDelegate.config.urliTunes]];
    [controller addImage:[UIImage imageNamed:_lego.preview]];
    [self presentViewController:controller animated:YES completion:Nil];
}
@end

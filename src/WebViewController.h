//
//  WebViewController.h
//  TunisieLigue1
//
//  Created by PHP Attitude on 18/09/13.
//  Copyright (c) 2013 Queen Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"
#import "GADBannerViewDelegate.h"

#import "GAITrackedViewController.h"
#import "MBProgressHUD.h"

@interface WebViewController : UIViewController <UIWebViewDelegate,GADBannerViewDelegate>
{
        IBOutlet UIWebView *webView;
        NSString *urlString;
    
    UIView *adTopView;
    GADBannerView *awView;
    BOOL isAdViewShown;
    BOOL isTopViewAdded;
      MBProgressHUD *hud;
    IBOutlet UIView *contenaire;
    NSString *language;
    NSString *adpublisher;
    NSString *textorientation;
    NSString *pubshow;
    NSString *publabel;
    NSString *cancelLabel;
}

- (id)initWithNibNameAndOptions:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString *)url lang:(NSString *)lang adpublisherID:(NSString *)adpublisherID pubshow:(NSString *)publishshow textorientation:(NSString *)orient publabel:(NSString *)label retourlabel:(NSString *)retourlabel;

@property (nonatomic,retain) MBProgressHUD *hud;

@property(nonatomic, retain) IBOutlet UIWebView *webView;
@property(nonatomic, retain) NSString *urlString;

@property(nonatomic,retain) UIView *adTopView;
@property(nonatomic,retain) GADBannerView *awView;
@property(nonatomic,retain)   IBOutlet UIView *contenaire;
@property (nonatomic,retain) NSString *language;
@property (nonatomic,retain) NSString *adpublisher;
@property (nonatomic,retain) NSString *textorientation;
@property (nonatomic,retain) NSString *pubshow;
@property (nonatomic,retain) NSString *publabel;
@property (nonatomic,retain) NSString *cancelLabel;
-(void)hideAdView;
@end

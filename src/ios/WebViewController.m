//
//  WebViewController.m
//  TunisieLigue1
//
//  Created by PHP Attitude on 18/09/13.
//  Copyright (c) 2013 Queen Creative. All rights reserved.
//

#import "WebViewController.h"

#define marginpub 85
#define marginview 155
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize webView,urlString;

@synthesize  adTopView;
@synthesize  awView;
@synthesize hud;
@synthesize contenaire;

@synthesize adpublisher;
@synthesize language;
@synthesize pubshow;
@synthesize textorientation;
@synthesize publabel;
@synthesize cancelLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibNameAndOptions:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString *)url lang:(NSString *)lang adpublisherID:(NSString *)adpublisherID pubshow:(NSString *)publishshow textorientation:(NSString *)orient publabel:(NSString *)label retourlabel:(NSString *)retourlabel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.language = lang;
        self.adpublisher = adpublisherID;
        self.pubshow = publishshow;
        self.textorientation = orient;
        self.publabel = label;
        self.urlString = url;
        self.cancelLabel = retourlabel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Do any additional setup after loading the view from its nib.
    UINavigationBar *naviBarObj ;
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 ) {
     naviBarObj = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
     }else{
     naviBarObj = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
     }
//    UIImage *navBarImg = [UIImage imageNamed:@"navig.png"];
//
//    [naviBarObj setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    [naviBarObj setBackgroundColor:[UIColor blackColor]];
    [naviBarObj setTintColor:[UIColor whiteColor]];
    [self.view addSubview:naviBarObj];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:self.cancelLabel       style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonPressed)];
    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@""];
    naviBarObj.items = [NSArray arrayWithObjects: navigItem,nil];
    navigItem.leftBarButtonItem = cancelItem;
   [ webView sizeThatFits:  CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-150)];

    NSLog(@"0,44, w >>%f,height>> %f",self.view.bounds.size.width, self.view.bounds.size.height);


    webView.opaque = YES;
    webView.scalesPageToFit = YES;
    webView.scrollView.zoomScale =4.0;
    //if(  [[[NSUserDefaults standardUserDefaults] stringForKey:@"pubshow"] isEqualToString : @"true"]) {
    if ([self.pubshow isEqualToString:@"true"]) {
        [self adMobProcess];
        [self.view bringSubviewToFront:awView];
        [self.view bringSubviewToFront:adTopView];
        isTopViewAdded=NO;
        // awView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
        awView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self.view addSubview:awView];
    }
}
- (void)webViewDidStartLoad:(UIWebView *)thisWebView
{
//	back.enabled = NO;
//	forward.enabled = NO;
    [hud show:YES];

}

- (void)webViewDidFinishLoad:(UIWebView *)thisWebView
{
    [ hud hide:YES];

}

-(void)webView:(UIWebView *)myWebView didFailLoadWithError:(NSError *)error {

   // NSLog(@"No internet connection");
  //  _connectionError.hidden = NO;
    [ hud hide:YES];
}

-(void)cancelButtonPressed {
    [self dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {

    //self.lang = [[NSUserDefaults standardUserDefaults] stringForKey:@"currentLanguage"];

    UILabel *pubLabel = (UILabel *)[self.view viewWithTag:1005];
    if([self.textorientation isEqualToString:@"RL"]){
        [pubLabel setTextAlignment:UITextAlignmentRight];

    } else{
        [pubLabel setTextAlignment:UITextAlignmentLeft];
    }
    pubLabel.text=self.publabel;


    if(    [self.pubshow isEqualToString : @"true"]) {
        [self.view bringSubviewToFront:awView];
        [self.view bringSubviewToFront:adTopView];
        CGRect newFrame = awView.frame;
        newFrame.origin.x = 0;
        //newFrame.origin.y = self.tableView.contentOffset.y+(self.tableView.frame.size.height-kAdWhirlViewHeight);

        if (isAdViewShown) {
            //newFrame.origin.y = self.tableView.contentOffset.y+319;
            newFrame.origin.y = 460;
        }else{
            //newFrame.origin.y = self.tableView.contentOffset.y+369;
            newFrame.origin.y = 500;
        }


        //awView.frame = newFrame;
        adTopView.frame = CGRectMake(0, awView.frame.origin.y-30, 320, 30);
        //DBF



        BOOL mustShowAds=YES;
                 if ((!isAdViewShown && isTopViewAdded && mustShowAds)  ) {
            // [tabview setFrame:CGRectMake(15, 60, 270, 150)];
            [self.view bringSubviewToFront:awView];[self.view bringSubviewToFront:adTopView];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            //adTopView.center=CGPointMake(160, 346);
            //awView.center=CGPointMake(160, 386);
            adTopView.center=CGPointMake(160, adTopView.center.y-49);
            awView.center=CGPointMake(160, awView.center.y-49);
            [UIView commitAnimations];
            isAdViewShown=YES;
            //[self performSelector:@selector(hideAdView) withObject:nil afterDelay:5.0];

        }


    }

	[super viewWillAppear:animated];

    if(urlString!=nil) {
        NSURLRequest *theRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
        [webView loadRequest:theRequest];
    }
}

#pragma mark -
#pragma mark AD VIEW TRANSLATION
-(void)adViewDidReceiveAd:(GADBannerView *)bannerView{
    //NSLog(@"adWhirlDidReceiveAd:");
    if (!isAdViewShown) {
        //  [self.scrollView setFrame:CGRectMake(0,0, 320, 289)];
        //   webcontent.frame  =  CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)(webcontent.frame.size.width,   webcontent.frame.size.height - 50);
    }else{
        //[self.scrollView setFrame:CGRectMake(0,0, 320,339)];
    }
    //   [self.view sendSubviewToBack:self.tableView];
    [self.view bringSubviewToFront:awView];[self.view bringSubviewToFront:adTopView];
    if (!isTopViewAdded) {
        adTopView=[[UIView alloc] initWithFrame:CGRectMake(0, 370, 320, 30)];
        adTopView.backgroundColor=[UIColor blackColor];

        UILabel *pubLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310, 30)];
        pubLabel.tag = 1005;
        if([self.textorientation isEqualToString:@"RL"]){
            [pubLabel setTextAlignment:UITextAlignmentRight];

        } else{
            [pubLabel setTextAlignment:UITextAlignmentLeft];
        }



        pubLabel.text=self.publabel;
        pubLabel.textColor=[UIColor redColor];
        pubLabel.backgroundColor=[UIColor clearColor];
        [adTopView bringSubviewToFront:pubLabel];
        [adTopView addSubview:pubLabel];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAdView)];
        [adTopView addGestureRecognizer:tap];
        isAdViewShown=YES;
        isTopViewAdded=YES;
        [self.view addSubview:adTopView];
        [self.view bringSubviewToFront:adTopView];
        [self.view bringSubviewToFront:awView];

        CGRect newFrame = awView.frame;
        newFrame.origin.x = 0;
        //newFrame.origin.y = self.tableView.contentOffset.y+(self.tableView.frame.size.height-kAdWhirlViewHeight);
        if (isAdViewShown) {
            //newFrame.origin.y = self.tableView.contentOffset.y+319;
             if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 ) {
                    newFrame.origin.y = 415+20;
             }else{
                 newFrame.origin.y = 415;


             }
        }else{
            //newFrame.origin.y = self.tableView.contentOffset.y+369;
            if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 ) {
                newFrame.origin.y = 460+20;
            }else{
                newFrame.origin.y = 460;

            }        }

        if(IS_WIDESCREEN){
            newFrame.origin.y += marginpub;
        }
        awView.frame = newFrame;
        adTopView.frame = CGRectMake(0, awView.frame.origin.y-30, 320, 30);

        //[self.view bringSubviewToFront:awView];[self.view bringSubviewToFront:adTopView];

    }

}

-(void)hideAdView{
    ////NSLog(@"hideAdView");

    if (!isAdViewShown) {
        //   [self.view bringSubviewToFront:toolbar];
        // [tabview setFrame:CGRectMake(15, 60, 270, 150)];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //adTopView.center=CGPointMake(160, 346);
        //awView.center=CGPointMake(160, 386);
        adTopView.center=CGPointMake(160, adTopView.center.y-49);
        awView.center=CGPointMake(160, awView.center.y-49);
        [UIView commitAnimations];
        isAdViewShown=YES;
        //[self performSelector:@selector(hideAdView) withObject:nil afterDelay:5.0];
        [self.view bringSubviewToFront:awView];[self.view bringSubviewToFront:adTopView];


    }
    else{
        //[tabview setFrame:CGRectMake(15, 60, 270, 200)];

        // [self.view sendSubviewToBack:awView];

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        //adTopView.center=CGPointMake(160,self.tableView.contentOffset.y+ 396);
        //awView.center=CGPointMake(160,self.tableView.contentOffset.y+ 436);

        awView.center=CGPointMake(160, awView.center.y+49);
        adTopView.center=CGPointMake(160, adTopView.center.y+49);
        [UIView commitAnimations];
        isAdViewShown=NO;


    }





}

-(void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"FAILURE RECEIVING AD: %@", [error localizedDescription]);
}


-(void)adMobProcess{

    NSLog(@"  { self.navigationController.view.frame.size.height-GAD_SIZE_320x50.height  } %f - %f",self.view.frame.size.height,GAD_SIZE_320x50.height);

    awView = [[GADBannerView alloc]initWithFrame:CGRectMake(0.0,
                                                            self.view.frame.size.height-GAD_SIZE_320x50.height,
                                                            GAD_SIZE_320x50.width,
                                                            GAD_SIZE_320x50.height)];
    self.awView.adUnitID =self.adpublisher;
    [self.awView setDelegate:self];

    [self.awView setRootViewController: self];
    // [self.view addSubview:awView];
    //  [self.view sendSubviewToBack:self.tableView];
    //[self.view bringSubviewToFront:awView];[self.view bringSubviewToFront:adTopView];

    GADRequest *request = [GADRequest request];

    // Make the request for a test ad. Put in an identifier for
    // the simulator as well as any devices you want to receive test ads.
    request.testDevices = [NSArray arrayWithObjects:@"9f89c84a559f573636a47ff8daed0d33", nil];
    //[bannerView_ loadRequest:request];
    request.testing = YES;
    [awView loadRequest: request ];

    //[awView loadRequest:[GADRequest request]];

}

-(void)awakeFromNib{
    NSLog(@"GOOD MORNING");
    [awView setDelegate:self];
}



@end

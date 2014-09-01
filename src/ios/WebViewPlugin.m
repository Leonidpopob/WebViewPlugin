//
//  WebViewPlugin.m
//  TunisieLigue
//
//  Created by Leonid on 5/20/14.
//
//

#import "WebViewPlugin.h"
#import "WebViewController.h"

@implementation WebViewPlugin

- (void) show:(CDVInvokedUrlCommand*)command
{
    WebViewController *view = nil;
    view = [[WebViewController alloc] initWithNibNameAndOptions:@"WebViewController" bundle:nil url: command.arguments[0] lang:command.arguments[1] adpublisherID:command.arguments[2] pubshow:command.arguments[3] textorientation:command.arguments[4] publabel:command.arguments[5] retourlabel:command.arguments[6]];
    //[self.commandDelegate runInBackground:^{
    [self.viewController presentViewController:view animated:YES completion:nil];
    //}];
    [self commandDelegate];
    
}

@end

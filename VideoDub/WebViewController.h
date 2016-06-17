//
//  WebViewController.h
//  VideoDub
//
//  Created by Aditya Narayan on 6/17/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController <WKNavigationDelegate>

@property (retain, nonatomic) NSURL * url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

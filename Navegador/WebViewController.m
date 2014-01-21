//
//  WebViewController.m
//  Navegador
//
//  Created by Murilo Campaner on 21/01/14.
//  Copyright (c) 2014 Murilo Campaner. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://google.com"];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)goUrl:(NSString*)urlString {
    NSURL *url = [NSURL URLWithString: urlString];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];
}



@end

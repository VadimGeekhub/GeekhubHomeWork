//
//  WebViewController.m
//  tableView.countries
//
//  Created by szalozniy on 10/21/13.
//  Copyright (c) 2013 szalozniy. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

-(void) startLoadingWebView {
    NSString *stringUrl = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", self.countryName];
    stringUrl = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(void) webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)setCountryName:(NSString *)value {
    _countryName = value;
    [self startLoadingWebView];
}


@end

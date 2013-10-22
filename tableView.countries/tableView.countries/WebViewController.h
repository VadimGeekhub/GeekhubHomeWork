//
//  WebViewController.h
//  tableView.countries
//
//  Created by szalozniy on 10/21/13.
//  Copyright (c) 2013 szalozniy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, strong) NSString *countryName;
@end

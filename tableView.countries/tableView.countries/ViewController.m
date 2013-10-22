//
//  ViewController.m
//  tableView.countries
//
//  Created by szalozniy on 10/21/13.
//  Copyright (c) 2013 szalozniy. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *countries;
@property (retain, nonatomic) NSLocale *locale;

@end

NSString * const COUNTRY_NAME_KEY = @"countryNameKey";
NSString * const COUNTRY_ISO_CODE = @"countryIsoCodeKey";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initCountries];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *selectedCoutry = self.countries[indexPath.row];
    WebViewController *info = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    [self.navigationController pushViewController:info animated:YES];
    info.countryName = selectedCoutry[COUNTRY_NAME_KEY];
    
}

-(void) initCountries {
    NSMutableArray *countriesTmp = [NSMutableArray array];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    self.locale = [[NSLocale alloc ] initWithLocaleIdentifier: @"en_US"];
    for (NSString *countryCode in countryArray) {
        NSString *displayNameString = [self.locale displayNameForKey:NSLocaleCountryCode value:countryCode];      /// NSLocaleCountryCode? countruCode?
        NSDictionary *countryInfo = @{COUNTRY_NAME_KEY :displayNameString,
                                      COUNTRY_ISO_CODE : countryCode};
        [countriesTmp addObject:countryInfo];
    }
    self.countries = [countriesTmp sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
        return [obj1[COUNTRY_NAME_KEY] compare:obj2[COUNTRY_NAME_KEY]];
    }];
}


-(UIImage *) countryFlagWith: (NSString *)isoCode {
    NSString *stingFlagUrl = [NSString stringWithFormat:@"http://www.translatorscafe.com/cafe/images/flags/%@.gif", isoCode];
    NSURL *flagUrl = [NSURL URLWithString:stingFlagUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:flagUrl];
    NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [UIImage imageWithData:imageData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.countries.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    NSDictionary *countryInfo = self.countries[indexPath.row];
    cell.textLabel.text = countryInfo[COUNTRY_NAME_KEY];
    cell.imageView.image = [self countryFlagWith:countryInfo[COUNTRY_ISO_CODE]];
    
    return cell;
}

@end

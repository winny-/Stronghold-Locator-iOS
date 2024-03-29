//
//  TutorialViewController.m
//  Stronghold Locator
//
//  Created by Winston Weinert on 2/1/14.
//  Copyright (c) 2014 Winston Weinert. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

#pragma mark - UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization when loaded programmatically.
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.web.delegate = self;
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"Tutorial" ofType:@"html"];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlFile isDirectory:NO]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [UIApplication.sharedApplication openURL:request.URL];
    return NO;
}

@end

//
//  BBWebViewController.m
//  Challenge
//
//  Created by Brian Broom on 5/12/14.
//  Copyright (c) 2014 Brian Broom. All rights reserved.
//

#import "BBWebViewController.h"

@interface BBWebViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BBWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

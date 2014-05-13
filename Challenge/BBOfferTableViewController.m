//
//  BBOfferTableViewController.m
//  Challenge
//
//  Created by Brian Broom on 5/12/14.
//  Copyright (c) 2014 Brian Broom. All rights reserved.
//

#import "BBOfferTableViewController.h"
#import "BBWebViewController.h"
#import "BBOfferCell.h"

@interface BBOfferTableViewController ()

@property (strong, nonatomic) NSMutableArray *offers;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;

@end

@implementation BBOfferTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib {
    
    [self.activityView startAnimating];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 150);
    self.activityView.color = [UIColor colorWithRed:0.4 green:0.4 blue:0.6 alpha:1.0];
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    
    NSURL *jsonUrl = [NSURL URLWithString:@"http://sheltered-bastion-2512.herokuapp.com/feed.json"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *getJsonTask = [session downloadTaskWithURL:jsonUrl completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *jsonData = [NSData dataWithContentsOfURL:location];
        _offers = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        [self.tableView reloadData];
        [self.activityView stopAnimating];
    }];
    
    [getJsonTask resume];
    
    //NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
    //self.offers = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.offers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBOfferCell *cell = (BBOfferCell *)[tableView dequeueReusableCellWithIdentifier:@"Offer" forIndexPath:indexPath];
    [cell configureWithDictionary:self.offers[indexPath.row]];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"websitePush"]) {
        BBWebViewController *webVC = (BBWebViewController *)segue.destinationViewController;
        webVC.urlString = self.offers[self.tableView.indexPathForSelectedRow.row][@"href"];        
    }
}

@end

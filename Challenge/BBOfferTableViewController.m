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
@property (strong, nonatomic) NSURLSession *session;

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
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 150);
    self.activityView.color = [UIColor colorWithRed:0.4 green:0.4 blue:0.6 alpha:1.0];
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    
    NSURL *jsonUrl = [NSURL URLWithString:@"http://sheltered-bastion-2512.herokuapp.com/feed.json"];
    self.session = [NSURLSession sessionWithConfiguration:nil];
    NSURLSessionDownloadTask *getJsonTask = [self.session downloadTaskWithURL:jsonUrl completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *jsonData = [NSData dataWithContentsOfURL:location];
        self.offers = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityView stopAnimating];
            [self.tableView reloadData];
        });
    }];
    
    [getJsonTask resume];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.session) {
        self.session = [NSURLSession sessionWithConfiguration:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.session finishTasksAndInvalidate];
    self.session = nil;
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
    [cell configureWithDictionary:self.offers[indexPath.row] andSession:self.session];
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

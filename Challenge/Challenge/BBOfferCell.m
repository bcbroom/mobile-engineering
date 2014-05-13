//
//  BBOfferCell.m
//  Challenge
//
//  Created by Brian Broom on 5/12/14.
//  Copyright (c) 2014 Brian Broom. All rights reserved.
//

#import "BBOfferCell.h"

@interface BBOfferCell ()

@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *attribLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@end

@implementation BBOfferCell

- (instancetype)configureWithDictionary:(NSDictionary *)options {
    
    self.descLabel.text = options[@"desc"];
    self.attribLabel.text = options[@"attrib"];
    self.userLabel.text = options[@"user"][@"name"];
    
    // nil out image, since the cell may be reused and have an image already loaded
    self.largeImageView.image = nil;
    self.userImageView.image = nil;
    
    NSURL *largeImageURL = [NSURL URLWithString:options[@"src"]];
    NSURL *userIconURL = [NSURL URLWithString:options[@"user"][@"avatar"][@"src"]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *largeImageTask = [session downloadTaskWithURL:largeImageURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.largeImageView.image = image;
        });
    }];
    
    NSURLSessionDownloadTask *userImageTask = [session downloadTaskWithURL:userIconURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.userImageView.image = image;
        });
    }];
    
    [largeImageTask resume];
    [userImageTask resume];
    
    return self;
}

@end

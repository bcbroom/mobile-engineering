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

    self.largeImageView.image = [UIImage imageNamed:@"image1.jpg"];
    self.descLabel.text = options[@"desc"];
    self.attribLabel.text = options[@"attrib"];
    self.userLabel.text = options[@"user"][@"name"];
    self.userImageView.image = [UIImage imageNamed:@"userIcon.png"];
    
    return self;
}

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
//
//- (void)awakeFromNib
//{
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end

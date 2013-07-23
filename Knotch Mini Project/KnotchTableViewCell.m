//
//  KnotchTableViewCell.m
//  Knotch Mini Project
//
//  Created by Chuan-Chih Chou on 13/07/22.
//  Copyright (c) 2013年 Chuan-Chih Chou. All rights reserved.
//

#import "KnotchTableViewCell.h"

CGFloat knotchMargin = 15;
CGFloat knotchTextMargin = 8;

@implementation KnotchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _colorBlockView = [[UIView alloc] initWithFrame:CGRectMake(knotchMargin, 0, self.frame.size.width - knotchMargin*2, 130/2)];
        [self.contentView insertSubview:self.colorBlockView belowSubview:self.detailTextLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.textLabel.frame = CGRectMake(knotchMargin + knotchTextMargin, 0, 30, 30);
    self.textLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:30];//[UIFont fontWithName:@"Didot-Bold" size:30];
    self.textLabel.text = @"“";
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.detailTextLabel.frame = CGRectMake(knotchMargin + knotchTextMargin, 10, self.frame.size.width - (knotchMargin + knotchTextMargin)*2, 55);
    self.detailTextLabel.font = [UIFont fontWithName:@"Aller-Light" size:12.5];
    self.detailTextLabel.numberOfLines = 3;
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTextLabel.textColor = [UIColor blackColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/
@end

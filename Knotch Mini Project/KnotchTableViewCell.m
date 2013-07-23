//
//  KnotchTableViewCell.m
//  Knotch Mini Project
//
//  Created by Chuan-Chih Chou on 13/07/22.
//  Copyright (c) 2013年 Chuan-Chih Chou. All rights reserved.
//

#import "KnotchTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "KnotchColor.h"

CGFloat KnotchMargin = 15;
CGFloat KnotchTextMargin = 8;

@implementation KnotchTableViewCell
@synthesize sentiment = _sentiment;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _colorBlockView = [[UIView alloc] initWithFrame:CGRectMake(KnotchMargin, 0, self.frame.size.width - KnotchMargin*2, 130/2)];
        [self.contentView insertSubview:self.colorBlockView belowSubview:self.detailTextLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.textLabel.frame = CGRectMake(KnotchMargin + KnotchTextMargin, 0, 30, 30);
    self.textLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:30];//[UIFont fontWithName:@"Didot-Bold" size:30];
    self.textLabel.text = @"“";
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    self.detailTextLabel.frame = CGRectMake(KnotchMargin + KnotchTextMargin, 10, self.frame.size.width - (KnotchMargin + KnotchTextMargin)*2, 55);
    self.detailTextLabel.font = [UIFont fontWithName:@"Aller-Light" size:12.5];
    self.detailTextLabel.numberOfLines = 3;
    self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTextLabel.textColor = [UIColor blackColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSentiment:(int)sentiment {
    
    if (sentiment == 10) { //White, "indifferent" sentiment
        
        self.textLabel.textColor = [UIColor blackColor];
        
        self.colorBlockView.layer.borderWidth = 1.0; //Default border color is opaque black already, no need to change
        self.colorBlockView.backgroundColor = [UIColor whiteColor];
        
    }
    else {
        
        self.textLabel.textColor = [UIColor whiteColor];
        
        self.colorBlockView.layer.borderWidth = 0.0;
        self.colorBlockView.backgroundColor = [KnotchColor sentiment:sentiment];
        
    }
    
    _sentiment = sentiment;
}

- (int) sentiment {
    return _sentiment;
}

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/
@end

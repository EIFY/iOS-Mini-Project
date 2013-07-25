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

const CGFloat KnotchMargin = 15;
const CGFloat KnotchTextMargin = 8;

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
    
    self.imageView.frame = CGRectMake(KnotchMargin + KnotchTextMargin, 3.0, 12.5, 10.5);
    
    self.textLabel.frame = CGRectMake(KnotchMargin + KnotchTextMargin, 10, self.frame.size.width - (KnotchMargin + KnotchTextMargin)*2, 55);
    self.textLabel.font = [UIFont fontWithName:@"Aller-Light" size:12.5];  // I was told to use Aller, but Aller-Light is more pleasant here :)
    self.textLabel.numberOfLines = 3;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSentiment:(int)sentiment {
    
    if (sentiment == 10) {  // White, "indifferent" sentiment
        
        self.imageView.image = [UIImage imageNamed:@"FeedQuoteSmallBlack.png"];
        
        self.colorBlockView.layer.borderWidth = 1.0;  // Default border color is opaque black already, no need to change
        self.colorBlockView.backgroundColor = [UIColor whiteColor];
        
    }
    else {
        
        self.imageView.image = [UIImage imageNamed:@"FeedQuoteSmall.png"];
        
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

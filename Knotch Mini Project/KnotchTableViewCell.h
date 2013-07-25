//
//  KnotchTableViewCell.h
//  Knotch Mini Project
//
//  Created by Chuan-Chih Chou on 13/07/22.
//  Copyright (c) 2013年 Chuan-Chih Chou. All rights reserved.
//

#import <UIKit/UIKit.h>

const CGFloat KnotchMargin;
const CGFloat KnotchTextMargin;

@interface KnotchTableViewCell : UITableViewCell

@property (readonly) UIView* colorBlockView;
@property (assign) int sentiment;

@end

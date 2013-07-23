//
//  ViewController.h
//  Knotch Mini Project
//
//  Created by Chuan-Chih Chou on 13/07/15.
//  Copyright (c) 2013年 Chuan-Chih Chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    CGFloat totalWidth, totalHeight;
    
    UIColor* nameFontColor;//Also turned out to be the font color for knotch topic
    
    UINavigationBar* usernameNavbar;
    
    UIImageView* profilePictureView;
    
    UILabel* nameLabel;    
    UILabel* locationLabel;
    
    UILabel* gloryCountLabel;
    UILabel* followerCountLabel;
    UILabel* followingCountLabel;
    
    CGFloat knotchTopicHeight;
    CGFloat knotchContentHeight;
    CGFloat knotchMargin;
    CGFloat knotchTextMargin;
    
    UITableView* knotchTableView;
    
    NSArray* KnotchSentimentColors;
    NSArray* knotches;
}
@end

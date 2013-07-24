//
//  ViewController.h
//  Knotch Mini Project
//
//  Created by Chuan-Chih Chou on 13/07/15.
//  Copyright (c) 2013年 Chuan-Chih Chou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    CGFloat totalWidth, totalHeight;
    
    UINavigationBar* usernameNavbar;
    
    UIScrollView* containerScrollView;
    
    UIImageView* profilePictureView;
    
    UILabel* nameLabel;    
    UILabel* locationLabel;
    
    UILabel* gloryCountLabel;
    UILabel* followerCountLabel;
    UILabel* followingCountLabel;
    
    NSArray* colorgraphicViews;
    UITableView* knotchTableView;
    
    NSArray* knotches;
    
    int numberOfKnotchesToLoad;
}
@end

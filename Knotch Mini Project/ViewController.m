//
//  ViewController.m
//  Knotch Mini Project
//
//  Created by Chuan-Chih Chou on 13/07/15.
//  Copyright (c) 2013年 Chuan-Chih Chou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	  // Do any additional setup after loading the view, typically from a nib.
    
    //NSLog(@"%f, %f", self.view.frame.size.width, self.view.frame.size.height);
    //Sanity check: 320.000000, 548.000000 indeed
    
    UINavigationBar* usernameNavbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 42.5)];
    [self.view addSubview:usernameNavbar];
    
    //usernameNavbar.topItem.title = @"Jane Doe";
    
    [usernameNavbar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"Anda Gansca"] animated:false];
    
    [usernameNavbar setBackgroundColor:[UIColor whiteColor]];
    usernameNavbar.tintColor = [UIColor whiteColor];
    usernameNavbar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor, [UIFont fontWithName:@"Aller" size:15], UITextAttributeFont, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0], UITextAttributeTextShadowColor, nil];
    [usernameNavbar setTitleVerticalPositionAdjustment:3 forBarMetrics:UIBarMetricsDefault];
    
    //UIOffsetMake(0, 0), UITextAttributeTextShadowOffset
    /*
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

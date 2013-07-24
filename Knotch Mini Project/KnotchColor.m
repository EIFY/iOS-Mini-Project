//
//  KnotchColor.m
//  Knotch Mini Project
//
//  Created by Chuan-Chih Chou on 13/07/23.
//  Copyright (c) 2013年 Chuan-Chih Chou. All rights reserved.
//

#import "KnotchColor.h"

static NSArray* knotchSentimentColors = nil;

UIColor* UIColorFromRGB(int rgbValue)
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

@implementation KnotchColor

// Objective-C singleton!

+ (void)initialize
{
    if(!knotchSentimentColors)
    {
        knotchSentimentColors = @[UIColorFromRGB(0x2e5ca6),
                                  UIColorFromRGB(0x586db9),
                                  UIColorFromRGB(0x008fd0),
                                  UIColorFromRGB(0x57cccc),
                                  UIColorFromRGB(0xceebee),
                                  UIColorFromRGB(0xffffff),
                                  UIColorFromRGB(0xffeec3),
                                  UIColorFromRGB(0xffcc43),
                                  UIColorFromRGB(0xffa02d),
                                  UIColorFromRGB(0xff6d3a),
                                  UIColorFromRGB(0xee443a)];
    }
}

+ (UIColor *)sentiment:(int) sentimentForColor
{
    return knotchSentimentColors[sentimentForColor/2];
}

@end

//
//  InfoCustomHeaderView.m
//  smdb-iphone
//
//  Created by csdc-iMac on 14-6-2.
//  Copyright (c) 2014年 Moe. All rights reserved.
//

#import "InfoCustomHeaderView.h"

@implementation InfoCustomHeaderView

-(id)initWithFrame:(CGRect)frame andTitle:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = MAIN_BACKCOLOR;
        UIView *singleLineView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 1)];
//        singleLineView.backgroundColor = THEME_COLOR;
        singleLineView.center = self.center;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 21)];
        titleLabel.text = title;
//        titleLabel.backgroundColor = MAIN_BACKCOLOR;
//        titleLabel.textColor = THEME_COLOR;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.center = self.center;
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:singleLineView];
        [self addSubview:titleLabel];
    }
    return self;
}

@end

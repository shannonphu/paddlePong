//
//  pongView.m
//  paddlePong
//
//  Created by Shannon Phu on 7/13/15.
//  Copyright (c) 2015 Shannon Phu. All rights reserved.
//

#import "pongView.h"

@implementation pongView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect ball = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    [[UIColor whiteColor] set];
    UIRectFill(ball);
}


@end

//
//  gameView.m
//  paddlePong
//
//  Created by Shannon Phu on 7/13/15.
//  Copyright (c) 2015 Shannon Phu. All rights reserved.
//

#import "gameView.h"

@implementation gameView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // draw midline
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat dashes[] = {1,1};
    CGContextSetLineDash(context, 0.0, dashes, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 5.0f);
    CGContextMoveToPoint(context, 0.0f, 0.0f);
    CGContextAddLineToPoint(context, 0.0f, 400.0f);
    CGContextStrokePath(context);
}


@end

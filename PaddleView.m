//
//  PaddleView.m
//  
//
//  Created by Shannon Phu on 7/13/15.
//
//

#import "PaddleView.h"

@implementation PaddleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect rectangle = CGRectMake(0.0f, 0.0f, 10.0f, 60.0f);
    [[UIColor whiteColor] set];
    UIRectFill(rectangle);
}


@end

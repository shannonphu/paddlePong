//
//  ViewController.m
//  paddlePong
//
//  Created by Shannon Phu on 7/12/15.
//  Copyright (c) 2015 Shannon Phu. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "pongView.h"
#import "gameView.h"

// GLOBALS
static float VELOCITY = 10.0f;

@interface ViewController () {
    @private
    CGPoint _velocty;
}
@property (nonatomic, strong) PaddleView *paddleViewLeft;
@property (nonatomic, strong) PaddleView *paddleViewRight;
@property (nonatomic, strong) pongView *ball;
@property (nonatomic, strong) gameView *gameView;

@property (weak, nonatomic) IBOutlet UILabel *labelLeft;
@property (weak, nonatomic) IBOutlet UILabel *labelRight;

@property (nonatomic) BOOL paused;
@property (nonatomic) NSUInteger scoreLeft;
@property (nonatomic) NSUInteger scoreRight;
@end


@implementation ViewController

@synthesize paddleViewLeft =_paddleViewLeft;
@synthesize paddleViewRight = _paddleViewRight;
@synthesize ball = _ball;
@synthesize labelLeft = _labelLeft;
@synthesize labelRight = _labelRight;
@synthesize paused = _paused;
@synthesize scoreLeft = _scoreLeft;
@synthesize scoreRight = _scoreRight;

- (void)viewWillAppear:(BOOL)animated
{
    // add midline
    self.gameView = [[gameView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2, 0.0f, 5.0f, self.view.bounds.size.height + 10)];
    [self.view addSubview:self.gameView];
    
    // add paddles
    self.paddleViewLeft = [[PaddleView alloc] initWithFrame:CGRectMake(15.0f, self.view.bounds.size.height / 2.5, 10.0f, 60.0f)];
    [self.view addSubview:self.paddleViewLeft];
    self.paddleViewRight = [[PaddleView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 15.0f, self.view.bounds.size.height / 2.5, 10.0f, 60.0f)];
    [self.view addSubview:self.paddleViewRight];
    
    // add ball
    self.ball = [[pongView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2, 15.0f, 15.0f)];
    [self.view addSubview:self.ball];
    
    // init score labels and scores
    self.scoreLeft = 0;
    self.scoreRight = 0;
    _velocty = CGPointMake(VELOCITY, VELOCITY);
    
    // schedule movement
    // repeatedly call play to allude to continuous movement of ball
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(play) userInfo:nil repeats:YES];
    [self kickoff];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // unpause if paused
    if (self.paused) {
        self.paused = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // follow user's finger vertically with right paddle
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    self.paddleViewRight.center = CGPointMake(self.paddleViewRight.center.x, location.y);
}

- (void)kickoff
{
    self.ball.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.paused = YES;
}

- (void)play
{
    // check if still paused
    if (self.paused)
        return;

    // move the ball
    self.ball.center = CGPointMake(self.ball.center.x + _velocty.x, self.ball.center.y + _velocty.y);
    
    // detect goals
    if (self.ball.center.x < 5) {
        self.scoreRight++;
        self.labelRight.text = [NSString stringWithFormat:@"%lu", self.scoreRight];
        [self kickoff];
    }
    else if (self.view.bounds.size.width - 5 < self.ball.center.x)
    {
        self.scoreLeft++;
        self.labelLeft.text = [NSString stringWithFormat:@"%lu", self.scoreLeft];
        [self kickoff];
    }
    
    // bounce off walls
    if (self.ball.center.y < 35 || self.view.bounds.size.height - 10 < self.ball.center.y) {
        _velocty.y = -_velocty.y;
    }
    
    // bounce off left paddle
    if (CGRectIntersectsRect(self.ball.frame, self.paddleViewLeft.frame) && self.paddleViewLeft.center.x <= self.ball.center.x) {
        _velocty.x = -_velocty.x;
    }
    
    // bounce off right paddle
    if (CGRectIntersectsRect(self.ball.frame, self.paddleViewRight.frame) && self.paddleViewRight.center.x > self.ball.center.x) {
        _velocty.x = -_velocty.x;
    }
    
    // move opponent as ball approaches
    if (_velocty.x < 0) {
        // move left paddle down
        if (self.ball.center.y < self.paddleViewLeft.center.y) {
            self.paddleViewLeft.center = CGPointMake(self.paddleViewLeft.center.x, self.paddleViewLeft.center.y - VELOCITY);
        }
        // move left paddle up
        else if (self.ball.center.y > self.paddleViewLeft.center.y) {
            self.paddleViewLeft.center = CGPointMake(self.paddleViewLeft.center.x, self.paddleViewLeft.center.y + VELOCITY);
        }
    }
}

- (void)setDifficulty:(int)level
{
    switch (level) {
        case 1:
            VELOCITY = 5.0f;
            break;
        case 2:
            VELOCITY = 8.0f;
            break;
        case 3:
            VELOCITY = 10.0f;
        case 4:
            VELOCITY = 13.0f;
            break;
        case 5:
            VELOCITY = 16.0f;
            break;
        case 6:
            VELOCITY = 19.0f;
            break;
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"playFromSettings"]) {
        if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
            ViewController *newVC = (ViewController *)segue.destinationViewController;
            newVC.navigationItem.hidesBackButton = YES;
            self.navigationController.navigationBar.hidden = YES;
        }
    }
}

@end















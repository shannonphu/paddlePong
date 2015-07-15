//
//  settingsViewController.m
//  paddlePong
//
//  Created by Shannon Phu on 7/13/15.
//  Copyright (c) 2015 Shannon Phu. All rights reserved.
//

#import "settingsViewController.h"
#import "ViewController.h"

@interface settingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *difficultyLabel;
@property (nonatomic)int difficulty;
@property (strong, nonatomic) UIColor *chosenColor;
@end

@implementation settingsViewController

@synthesize chosenColor = _chosenColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeDifficulty:(id)sender {
    UIStepper *stepper = sender;
    self.difficulty = [stepper value];
    self.difficultyLabel.text = [NSString stringWithFormat:@"%d", self.difficulty];
}


- (IBAction)choseColor:(id)sender {
    UIButton *button = sender;
    self.chosenColor = button.backgroundColor;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"playFromSettings"]) {
        if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
            ViewController *newVC = (ViewController *)segue.destinationViewController;
            newVC.navigationItem.hidesBackButton = YES;
            self.navigationController.navigationBar.hidden = YES;
            newVC.view.backgroundColor = self.chosenColor ? self.chosenColor : [UIColor blackColor];
            [newVC setDifficulty:self.difficulty];
        }
    }
}


@end

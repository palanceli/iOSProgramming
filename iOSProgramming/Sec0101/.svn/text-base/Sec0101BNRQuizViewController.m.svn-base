//
//  Sec0101BNRQuizViewController.m
//  iOSProgramming
//
//  Created by palance on 15/8/26.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0101BNRQuizViewController.h"
#import "Sec0101InformationViewController.h"


@interface Sec0101BNRQuizViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;
@property (nonatomic) int currentQuestionIndex;

@end

@implementation Sec0101BNRQuizViewController

#pragma mark - 初始化
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.questions = @[@"From what is cognac made?",
                           @"What is 7+7?",
                           @"What is the capital of Vermont?"];
        self.answers = @[@"Grapes", @"14", @"Montpelier"];
        self.currentQuestionIndex = 0;
    }
    return self;
}

-(void)viewDidLoad
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - 响应消息
- (IBAction)showQuestion:(id)sender {
    self.currentQuestionIndex++;
    if (self.currentQuestionIndex == self.questions.count) {
        self.currentQuestionIndex = 0;
    }
    self.questionLabel.text = self.questions[self.currentQuestionIndex];
    self.answerLabel.text = @"???";
}

- (IBAction)showAnswer:(id)sender {
    self.answerLabel.text = self.answers[self.currentQuestionIndex];
}

- (IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Sec0101InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Sec0101InformationViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

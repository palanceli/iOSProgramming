//
//  Sec0602BNRQuizViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0602BNRQuizViewController.h"

@interface Sec0602BNRQuizViewController()
@property (weak, nonatomic) IBOutlet UILabel *questionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *answersLabel;

@property (strong, nonatomic) NSArray *questionsArray;
@property (strong, nonatomic) NSArray *answersArray;
@property (nonatomic) int currentQuestionIndex;

@end
@implementation Sec0602BNRQuizViewController
-(void)viewDidLoad
{
    self.questionsArray = @[@"From what is cognac made?",
                            @"What is 7+7?",
                            @"What is the capital of Vermont?"];

    self.answersArray = @[@"Grapes", @"14", @"Montpelier"];
    self.currentQuestionIndex = 0;
}

- (IBAction)showQuestions:(id)sender
{
    self.currentQuestionIndex++;
    if (self.currentQuestionIndex == self.questionsArray.count) {
        self.currentQuestionIndex = 0;
    }
    self.questionsLabel.text = self.questionsArray[self.currentQuestionIndex];
    self.answersLabel.text = @"???";

}

- (IBAction)showAnswers:(id)sender
{
    self.answersLabel.text = self.answersArray[self.currentQuestionIndex];

}
@end

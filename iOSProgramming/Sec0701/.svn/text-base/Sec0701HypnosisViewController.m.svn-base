//
//  Sec0710HypnosisViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0701HypnosisViewController.h"
@interface Sec0701HypnosisViewController()<UITextFieldDelegate>
@end

@implementation Sec0701HypnosisViewController
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnosisMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    
    return YES;
}

-(void)drawHypnosisMessage:(NSString *)message
{
    for (int i=0; i<20; i++) {
        UILabel *messageLabel = [[UILabel alloc]init];
        
        messageLabel.text = message;
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        
        [messageLabel sizeToFit];
        
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        messageLabel.frame = frame;
        
        [self.view addSubview:messageLabel];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}

@end

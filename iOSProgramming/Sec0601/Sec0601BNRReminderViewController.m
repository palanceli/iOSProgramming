//
//  Sec0601BNRReminderViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/2.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0601BNRReminderViewController.h"

@interface Sec0601BNRReminderViewController()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation Sec0601BNRReminderViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    
    UILocalNotification *note = [[UILocalNotification alloc]init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    
    [[UIApplication sharedApplication]scheduleLocalNotification:note];
}

@end

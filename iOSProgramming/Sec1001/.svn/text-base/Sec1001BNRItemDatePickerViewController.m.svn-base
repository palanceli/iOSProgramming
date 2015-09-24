//
//  Sec1001BNRItemDatePickerViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1001BNRItemDatePickerViewController.h"
#import "Sec1001BNRItem.h"

@interface Sec1001BNRItemDatePickerViewController()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@end

@implementation Sec1001BNRItemDatePickerViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.datePicker.date = self.item.dateCreated;
    self.timePicker.date = self.item.dateCreated;
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateFormat:@"HH-mm-ss"];
    NSString *strDateTime = [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:self.datePicker.date], [timeFormatter stringFromDate:self.timePicker.date]];
    
    NSDateFormatter *datetimeFormatter = [[NSDateFormatter alloc]init];
    [datetimeFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    self.item.dateCreated = [datetimeFormatter dateFromString:strDateTime];
    NSLog(@"new date time:%@", strDateTime);
}
@end

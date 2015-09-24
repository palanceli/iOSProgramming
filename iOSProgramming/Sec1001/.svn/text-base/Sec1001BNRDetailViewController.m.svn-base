//
//  Sec1001BNRDetailViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1001BNRDetailViewController.h"
#import "Sec1001BNRItem.h"
#import "Sec1001BNRItemDatePickerViewController.h"

@interface Sec1001BNRDetailViewController()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *serialTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation Sec1001BNRDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.nameTextField.text = self.item.itemName;
    self.serialTextField.text = self.item.serialNumber;
    self.valueTextField.text = [@(self.item.valueInDollars) stringValue];
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
    self.navigationItem.title = self.item.itemName;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    self.item.itemName = self.nameTextField.text;
    self.item.serialNumber = self.serialTextField.text;
    self.item.valueInDollars = [self.valueTextField.text intValue];
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)changeCreateDateTime:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Sec1001BNRItemDatePickerViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Sec1001BNRItemDatePickerViewController"];
    vc.item = self.item;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

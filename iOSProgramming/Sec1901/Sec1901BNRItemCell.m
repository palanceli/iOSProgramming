//
//  Sec1901BNRItemCell.m
//  iOSProgramming
//
//  Created by palance on 15/9/26.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "Sec1901BNRItemCell.h"
@interface Sec1901BNRItemCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidthContraint;

@end

@implementation Sec1901BNRItemCell
- (IBAction)showImage:(id)sender {
    // 调用Block对象之前要检查Block对象是否存在
    if (self.actionBlock) {
        self.actionBlock();
    }
}

-(void)updateInterfaceForDynamicTypeSize
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    
    static NSDictionary *imageSizeDictionary;
    if (!imageSizeDictionary) {
        imageSizeDictionary = @{
                                UIContentSizeCategoryExtraSmall : @40,
                                UIContentSizeCategorySmall : @40,
                                UIContentSizeCategoryMedium : @40,
                                UIContentSizeCategoryLarge : @40,
                                UIContentSizeCategoryExtraLarge : @45,
                                UIContentSizeCategoryExtraExtraLarge : @55,
                                UIContentSizeCategoryExtraExtraExtraLarge : @65
                                };
    }
    NSString *userSize = [[UIApplication sharedApplication]preferredContentSizeCategory];
    
    NSNumber *imageSize = imageSizeDictionary[userSize];
    self.imageViewHeightContraint.constant = imageSize.floatValue;
    self.imageViewWidthContraint.constant = imageSize.floatValue;
}

-(void)awakeFromNib
{
    [self updateInterfaceForDynamicTypeSize];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(updateInterfaceForDynamicTypeSize) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

-(void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

@end

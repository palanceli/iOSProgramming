//
//  Sec1901BNRDetailViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/26.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "Sec1901BNRDetailViewController.h"
#import "Sec1901BNRItemStore.h"
#import "Sec1901BNRItem.h"
#import "Sec1901BNRImageStore.h"

@interface Sec1901BNRDetailViewController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *serialTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toobar;
@property (weak, nonatomic) IBOutlet UIButton *clearImageButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@property (strong, nonatomic)UIPopoverController *imagePickerPopover;
@end

@implementation Sec1901BNRDetailViewController

#pragma mark - 初始化
-(instancetype)initForNewItem:(BOOL)isNew
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"Sec1901BNRDetailViewController"];
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
    }
    return self;
}
#pragma mark - 当为模态对话框时的save/cancel响应函数
-(void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

-(void)cancel:(id)sender
{
    [[Sec1901BNRItemStore sharedStore]removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 转屏相关
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    }else{
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}

-(void)prepareViewsForOrientation:(UIInterfaceOrientation)orientation
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    }else{
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self prepareViewsForOrientation:toInterfaceOrientation];
}

//-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//    if () {
//
//    }
//}

#pragma mark -

-(void)viewDidLayoutSubviews
{
    //    for (UIView *subview in self.view.subviews) {
    //        if ([subview hasAmbiguousLayout]) {
    //            NSLog(@"AMBIGUOUS: %@", subview);
    //        }
    //    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIInterfaceOrientation io = [[UIApplication sharedApplication]statusBarOrientation];
    [self prepareViewsForOrientation:io];
    
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
    
    NSString *key = self.item.itemKey;
    UIImage *image = [[Sec1901BNRImageStore sharedStore]imageForKey:key];
    self.imageView.image = image;
    if (image == nil) {
        self.clearImageButton.hidden = YES;
    }else{
        self.clearImageButton.hidden = NO;
    }
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
    //    for (UIView *subview in self.view.subviews) {
    //        if ([subview hasAmbiguousLayout]) {
    //            [subview exerciseAmbiguityInLayout];
    //        }
    //    }
}

- (IBAction)takePicture:(id)sender {
    // 如果imagePicker处于正在弹出的状态，则关闭返回
    if ([self.imagePickerPopover isPopoverVisible]) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;        
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.imagePickerPopover = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
        self.imagePickerPopover.delegate = self;
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else{
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"User dismissed popover");
    self.imagePickerPopover = nil;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.item setThumbnailFromImage:image];
    
    [[Sec1901BNRImageStore sharedStore]setImage:image forKey:self.item.itemKey];
    
    self.imageView.image = image;
    // 关闭UIImagePickerController对象
    if (self.imagePickerPopover) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)clearImage:(id)sender {
    [[Sec1901BNRImageStore sharedStore]deleteImageForKey:self.item.itemKey];
    self.imageView.image = nil;
    self.clearImageButton.hidden = YES;
}

@end

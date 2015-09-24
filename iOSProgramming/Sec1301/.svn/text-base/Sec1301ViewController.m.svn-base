//
//  Sec1301ViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/8.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1301ViewController.h"
#import "InformationViewController.h"

@implementation Sec1301ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
    vc.informationString = @"添加UIGestureRecognizer的过程：\n\
    1、在ini...初始化函数中创建UIGestureRecognizer对象，并绑定处理函数\n\
    2、调用窗体的addGestureRecognizer将UIGestureRecognizer对象添加到处理窗体\n\
    3、定义处理函数\n\n\
    如果UIGestureRecognizer和触摸消息（touchesBegan）冲突，则需要将UIGestureRecognizer的delaysTouchesBegan置为YES；如果两个UIGestureRecognizer之间冲突，比如单双击之间，需要确认不是双击才响应单击，则需要调用单击对象的requireGestureRecognizerToFail:方法，并传入双击对象，这样确保再确认不是双击后才处理单击事件；如果两个UIGestureRecognizer要交叉处理，比如长按（UILongPressGestureRecognizer）之后的拖动（UIPanGestureRecognizer），就需要视图遵守UIGestureRecognizerDelegate协议，并覆盖gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer方法，当某个UIGestureRecognizer子类对象识别出特定手势后，如果发现其他UIGestureRecognizer子类对象也识别出了该手势，就会向其委托对象发送gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer消息。如果返回YES，则当前UIGestureRecognizer子类对象就会和其他UIGestureRecognzier子类对象共享UITouch对象。\n\n\
    显示菜单的过程：\n\
    1、将所在视图设置为第一响应者[self becomeFirstResponder];\n\
    2、覆盖本视图的-(BOOL)canBecomeFirstResponder方法，使之总是返回YES\n\
    3、创建一个UIMenuController和若干UIMenuItem子项，并为每个子项绑定响应函数，将子项加入UIMenuController对象的menuItems数组中\n\
    4、设置UIMenuController的位置，并将MenuVisible置为YES\n\
    5、需要取消菜单时，调用[[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];\n\n\n\
    为什么我画一条线，先收到四个shouldRecognizeSimultaneouslyWithGestureRecognizer消息（state=Began），然后收到四个panGestureRecognizer消息，再收到三个shouldRecognizeSimultaneouslyWithGestureRecognizer消息（state=Changed），再收到一个panGestureRecognizer消息，之后才收到touchesBegan？\n\
    ";
    [self.navigationController pushViewController:vc animated:YES];
}

@end

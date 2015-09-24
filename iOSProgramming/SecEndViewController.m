//
//  SecEndViewController.m
//  iOSProgramming
//
//  Created by palance on 15/8/26.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "SecEndViewController.h"
#import "InformationViewController.h"

@interface SecEndViewController()
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;

@end

@implementation SecEndViewController
-(void)viewDidLoad
{
    NSString *infoString = @"Q1:怎么让TextField支持多行输入？让Label支持上对齐？以及二者的字体字号的设置。\n\
Q2:怎么让大量文本从文件中读出，而不要硬编码到代码中\n\
Q3:关于点语法，obj.method=xxx，理论上调用了[obj setmethod:xxx]，但如果obj刚好有一个method的成员变量，此点语法会调用谁呢？OC的成员变量是没有私有之说的，原则上允许直接访问吧？直接访问的方法只有点语法吧？\n\
A3:当obj的类有var成员变量的时候，我在该类的方法中使用self.var的写法会报语法错误，让我纠正成self->var\n\
Q4:在P49中提到：OC的命名约定很重要，应该严格遵守，忽视OC的命名约定会产生问题，其严重程度将远超大部分初学者的预期，能列举一下都会有什么问题吗？\n\
Q5:P52中提到：不要直接访问实例变量，而要使用存取方法。但在初始化方法中相反，应该直接访问实例变量。原因是执行初始化方法时，无法确定新创建的对象的实例变量是否已经处于正确设置，可能不是正确的值，也可能没有被正确分配，如果这时调用存取方法，可能会引起错误。但我认为问题的关键不在于是否使用了存取方法，如果没有被正确分配，即使直接访问，也是有问题的。书中紧接着又说也有一派很优秀的程序员坚持在初始化时也使用存取方法……两种做法都有道理。我不是很明白，前面既然说过这种做法可能引起错误，那为什么还“都有道理”呢？一种可能性是，这引发的问题不是在机制层，而是在应用层。需要找出这样的例子。\n\
\n\
Q6:在story board 中的identity inspector中的Document - Label该项是什么意思？\n\
Q7:比较一下C++的构造函数和OC的初始化函数的异同。\n\
Q8:直接打印NSDate类型的数据，现实的是GMT时间，怎么转换为本地时间？\n\
A8:通过如下代码可以搞定，详见Sec0201 BNRItem description：\n\
    NSDateFormatter *dsFormatter = [[NSDateFormatter alloc]init];\n\
    [dsFormatter setDateFormat:@\"yyyy-MM-dd HH:mm:ss\"];\n\
    NSString *dateTimeString = [dsFormatter stringFromDate:self.dateCreated];\n\
    \n\
Q9:nonatomic和atomic的区别？\n\
Q10:view.bounds.origin标示当前视图左上角的坐标，我理解就相当于坐标原点，那不始终应该是(0, 0)么？有什么情况会是非零的呢？\n\
Q11:当NavigationViewController被新的窗体压栈后，新窗体的back按钮本来应该是前一个窗体的navigationController.title，但是如果签一个窗体的title过长，系统就会自动把back按钮的title改为“< Back”，怎么修改这个按钮呢？如Sec0401的Info窗体\n\
Q12:从Storyboard通过instantiateViewControllerWithIdentifier载入的窗体，如果希望修改其内部空间的值，并能在窗体展现时生效，该怎么做？比如修改一个Label，我尝试vc.textLabel.text = @\"xxx\";然后再调用[vc.view setNeedsDisplay];还是不灵\n\
Q13:当使用相机照相时，我想在取景窗的中央画十字，怎么获取取景窗的尺寸和位置？我的做法是拿到当前view的位置，这和取景窗是不一样的。\n\
\n\
    \n\
    \n\
注意1：NSArray和NSMutableArray只能保存指向OC的对象指针，不能将基本类型变量或者C结构体加入数组对象。不能将nil加入数组对象，如果要将“空”加入，就必须使用NSNull。\n\n\
    属性的copy特性，使用copy特性的属性的set方法相当于以下代码：\n\
    -(void)setItemName:(NSString*)itemName\n\
    {\n\
        _itemName = [itemName copy];\n\
    }\n\
                            ";
    self.informationLabel.text = infoString;
	
	UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
	self.navigationItem.rightBarButtonItem = rightBarButtonItem;
	
}

-(IBAction)showInformation:(id)sender
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
	vc.informationString = @"xxx";
	[self.navigationController pushViewController:vc animated:YES];
}
@end

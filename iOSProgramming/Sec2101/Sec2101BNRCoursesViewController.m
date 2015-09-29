//
//  Sec2101BNRCourses.m
//  iOSProgramming
//
//  Created by palance on 15/9/29.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "Sec2101BNRCoursesViewController.h"
#import "InformationViewController.h"
#import "Sec2101BNRWebViewController.h"

@interface Sec2101BNRCoursesViewController()<NSURLSessionDataDelegate>
@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;
@end

@implementation Sec2101BNRCoursesViewController
#pragma mark - 初始化方法
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainSec21" bundle:nil];
        self.webViewController = [storyboard instantiateViewControllerWithIdentifier:@"Sec2101BNRWebViewController"];
        [self fetchFeed];
    }
    return self;
}

-(void)fetchFeed
{
//    NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.courses = jsonObject[@"courses"];
        NSLog(@"course count :%lu", (unsigned long)self.courses.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [dataTask resume];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"BigNerdRanch" password:@"AchieveNerdvana" persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Sec2101BNRTableViewCell"];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
    vc.informationString = @"在iOS9 beta1中，苹果将原http协议改成了https协议，使用 TLS1.2 SSL加密请求数据。因此默认情况下，在fetchFeed中的http请求会被提示：\n\
    Application Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.\n\
    需要在info.plist文件中加入：\n\
    <key>NSAppTransportSecurity</key>\n\
    <dict>\n\
      <key>NSAllowsArbitraryLoads</key>\n\
      <true/>\n\
    </dict>\n\
    ";
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableViewDataSource 方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Sec2101BNRTableViewCell" forIndexPath:indexPath];
    NSDictionary *courses = self.courses[indexPath.row];
    cell.textLabel.text = courses[@"title"];
    
    return cell;
}

#pragma mark - UITableViewDelagate 方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSDictionary *course = self.courses[indexPath.row];
    NSURL *URL = [NSURL URLWithString:course[@"url"]];
    
    self.webViewController.title = course[@"title"];
    self.webViewController.URL = URL;
    [self.navigationController pushViewController:self.webViewController animated:YES];
}
@end

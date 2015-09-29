//
//  Sec2101BNRWebViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/29.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "Sec2101BNRWebViewController.h"

@implementation Sec2101BNRWebViewController
-(void)setURL:(NSURL *)URL
{
    _URL = URL;
    if (_URL) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}
@end

//
//  HYViewController.m
//  HybridKit
//
//  Created by Mert Dümenci on 18/07/13.
//  Copyright (c) 2013 Propeller. All rights reserved.
//

#import "HYViewController.h"

#ifndef IS_IOS7
#define IS_IOS7 !([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)
#endif

@interface HYViewController ()

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *testHTMLPath = [[NSBundle mainBundle] pathForResource:@"test_html" ofType:@"html"];
    NSString *HTMLString = [NSString stringWithContentsOfFile:testHTMLPath encoding:NSUTF8StringEncoding error:nil];

    [self.webView setMultipleTouchEnabled:NO];

    self.htmlString = HTMLString;
    self.delegate = self;
  
    if (IS_IOS7) {
        self.webView.scrollView.scrollIndicatorInsets = self.webView.scrollView.contentInset = UIEdgeInsetsMake(66, 0, 0, 0);
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *myParameter = @"myParameter";
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"callmeFromObjC('%@')", myParameter]];
    });
    
}

- (BOOL)hybridWebViewController:(HYWebViewController *)webViewController onWebCommand:(NSDictionary *)jsonDictionary;
{
    NSLog(@"%@", jsonDictionary);
    
    if ([[jsonDictionary objectForKey:@"command"] isEqualToString:@"xm_play_music"]) {
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"sdfd" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];

        HYViewController *vc = [[HYViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
        return YES;
    }
    return NO;
}

@end
